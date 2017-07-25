#include <X11/Xlib.h>
//#include <X11/Xresource.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

struct client_params {
   int x;
   int y;
   int w;
   int h;
};

int getDelay () {
   FILE *fp;
  char path[1035];

  /* Open the command for reading. */
  fp = popen("zenity --entry --title \"ScreenRecorder\" --text \"To create screencast.gif in /home/andrew/Pictures enter the gif duration in seconds:\" --width 200 --height 100", "r");
  if (fp == NULL) {
    printf("Failed to run command\n" );
    exit(1);
  }

  /* Read the output a line at a time - output it. */
  while (fgets(path, sizeof(path)-1, fp) != NULL) {
    printf("%s", path);
  }
  /* close */
  pclose(fp);
  return atoi(path);
}
struct client_params get_coord()
{
    Display *dpy;
    XEvent ev;

    GC sel_gc;
    XGCValues sel_gv;

    int x, y, i;
    int start_x, start_y, width, height;


    if (!(dpy = XOpenDisplay(NULL))) {
        fprintf(stderr, "Could not open display %s", getenv("DISPLAY"));
    }

    XGrabButton(dpy, 1, 0, DefaultRootWindow(dpy), True, ButtonPressMask, GrabModeSync, GrabModeAsync, None, None);

    sel_gv.function = GXinvert;
    sel_gv.subwindow_mode = IncludeInferiors;
    sel_gv.line_width = 1;
    sel_gc = XCreateGC(dpy, DefaultRootWindow(dpy), GCFunction | GCSubwindowMode | GCLineWidth, &sel_gv);

    for (;;) {
        XNextEvent(dpy, &ev);

        if (ev.type == ButtonPress) {
            /* Grab pointer so we receive ButtonRelease */
            XGrabPointer(dpy, DefaultRootWindow(dpy), True, PointerMotionMask | ButtonReleaseMask, GrabModeAsync, GrabModeAsync, None, None, CurrentTime);
            x = start_x = ev.xbutton.x_root;
            y = start_y = ev.xbutton.y_root;

            width = height = 0;

            //XAllowEvents(dpy, ReplayPointer, CurrentTime); /* Allow other apps to process this message */
        } else if (ev.type == MotionNotify) {
            while (XCheckTypedEvent(dpy, MotionNotify, &ev));

            XDrawRectangle(dpy, DefaultRootWindow(dpy), sel_gc, x, y, width, height); /* Clear Rectangle */

            width = ev.xbutton.x_root - start_x;
            height = ev.xbutton.y_root - start_y;

            /* Ugliness to make width/height positive and put the start positions
             * in the right place so we can draw backwards basically. */
            if (width < 0) { width = abs(width); x = ev.xbutton.x_root; } else { x = start_x; }
            if (height < 0) { height = abs(height); y = ev.xbutton.y_root; } else { y = start_y; }

            XDrawRectangle(dpy, DefaultRootWindow(dpy), sel_gc, x, y, width, height); /* Draw Rectangle */
        } else if (ev.type == ButtonRelease) {
            XUngrabPointer(dpy, CurrentTime);

            XDrawRectangle(dpy, DefaultRootWindow(dpy), sel_gc, x, y, width, height); /* Clear Rectangle */

            XSync(dpy, 1); /* Needed to Ungrab Pointer NOW otherwise we continue receiving MotionNotify events and the previous line is useless */
            struct client_params params = {x, y, width, height};
            return params;
        }
    }

    XFreeGC(dpy, sel_gc);

    XCloseDisplay(dpy);

}
char* currentTime() {
  time_t rawtime;
  struct tm * timeinfo;
  time ( &rawtime );
  timeinfo = localtime ( &rawtime );
  return asctime (timeinfo);
}
void beep() {
    system("/usr/bin/paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga");
}
int main() {
    int dur = getDelay();
    if (dur == 0) {
        return;
    }
    struct client_params a = get_coord();
    char *command = (char*)malloc(1000 * sizeof(char));
    sprintf(
        command,
        "/usr/bin/byzanz-record -c --verbose --delay=0 --duration=%d --x=%d --y=%d --width=%d --height=%d \"/home/andrew/Pictures/%s.gif\"",
        dur,
        a.x,
        a.y,
        a.w,
        a.h,
        currentTime()
        );
    printf("executing: %s", command);
    usleep(1000000);
    beep();
    int status = system(command);
    beep();
    return status;
}