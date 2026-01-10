
// DEPRECATED
// USE https://github.com/akoidan/media-launcher
import {promises as fs} from 'fs';
import * as path from 'path';
import {platform} from 'os';

const structure: Record<number, { audio: string[], video: string|null, subtitles: string[] }> = {}

let fontDir: string|null= null

const scriptExt = platform() == 'win32' ? 'cmd' : 'bash';
const programName = platform() == 'win32' ? 'mvp.exe' : 'mpv';

async function readDirRecursive(dirPath: string): Promise<void> {
  const entries = await fs.readdir(dirPath, {withFileTypes: true});

  for (const entry of entries) {
    const fullPath = path.join(dirPath, entry.name);
    if (entry.isDirectory()) {
      if (entry.name.toLowerCase().includes('font') || entry.name.toLowerCase().includes('шрифты')) {
        fontDir = fullPath;
      } else {
        await readDirRecursive(fullPath);
      }
    } else {
      if (entry.name.toLowerCase().endsWith('.cmd') || entry.name.toLowerCase().endsWith('.bash')) {
        continue;
      }
      if (!entry.name.endsWith('.mkv') && !entry.name.endsWith('.ass') && !entry.name.endsWith('.mka') && !entry.name.endsWith('.ttf')) {
        console.error(`Unkown file ${entry.name}`);
        continue
      }
      let episode = 0;
      let regExpMatchArray = entry.name.match(/E(\d\d)/);
      if (regExpMatchArray) {
        episode = parseInt(regExpMatchArray![1], 10);
      } else {
        regExpMatchArray = entry.name.match(/\d\d/);
        if (!regExpMatchArray) {
          console.error(`file ${entry.name} doesn't have epoisode #`);
          continue
          // throw new Error(`${entry.name} is not a file`);
        }
        episode = parseInt(regExpMatchArray![0], 10);
      }


      if (!structure[episode]) {
        structure[episode] = {
          audio: [],
          subtitles: [],
          video: null,
        };
      }
      if (episode === undefined) {
        throw new Error(`Cannot read file ${fullPath}`);
      }
      if (entry.name.endsWith('mkv')) {
        structure[episode].video = fullPath;
      }
      if (entry.name.endsWith('ass')) {
        structure[episode].subtitles.push(fullPath);
      }
      if (entry.name.endsWith('mka')) {
        structure[episode].audio.push(fullPath);
      }
    }
  }
}

async function main(rootDIr: string) {
  await readDirRecursive(path.resolve(rootDIr));
  for (const [key, value] of Object.entries(structure)) {
    if (!value.video) {
      continue
      throw Error(`Cannot find main file for epise ${key}`);
    }
    let openFile = `${programName} "${value.video}"`;
    for (const audio of value.audio) {
      openFile += ` --audio-file="${audio}"`
    }
    for (const subtitle of value.subtitles) {
      openFile += ` --sub-file="${subtitle}"`
    }
    if (fontDir) {
      openFile += ` --sub-fonts-dir="${fontDir}"`
    }
    const exeScriptPath = path.join(rootDIr, `${String(key).padStart(2, '0')}.${scriptExt}`);
    await fs.writeFile(exeScriptPath, openFile, 'utf8');
    await fs.chmod(exeScriptPath, 0o755);
  }
}

main('/home/andrew/ntfs/movies/Goblin Slayer II/').catch(err => {
  console.error('Failed to write directory structure:', err);
});
