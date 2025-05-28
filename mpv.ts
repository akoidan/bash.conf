import {promises as fs} from 'fs';
import * as path from 'path';

const structure: Record<number, { audio: string[], video: string|null, subtitles: string[] }> = {}

let fontDir: string|null= null

async function readDirRecursive(dirPath: string): Promise<void> {
    const entries = await fs.readdir(dirPath, {withFileTypes: true});
    for (const entry of entries) {
        const fullPath = path.join(dirPath, entry.name);
        if (entry.isDirectory()) {
            if (entry.name.toLowerCase().includes('font')) {
                fontDir = fullPath;
            } else {
                await readDirRecursive(fullPath);
            }
        } else {
            if (entry.name.toLowerCase().endsWith('bash')) {
                continue;
            }
            let regExpMatchArray = entry.name.match(/\d\d/);
            if (!regExpMatchArray) {
                throw new Error(`${entry.name} is not a file`);
            }
            const episode = parseInt(regExpMatchArray![0], 10);
            if (!structure[episode]) {
                structure[episode] = {
                    audio: [],
                    subtitles: [],
                    video: null,
                };
            }
            if (!episode) {
                throw new Error(`Cannot read directory ${fullPath}`);
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

async function main() {
    const rootDIr = "/home/andrew/ntfs/movies/Wajutsushi [WEB-DL CR 1080p AVC AAC]/";
    await readDirRecursive( path.resolve(rootDIr));
    for (const [key, value] of Object.entries(structure)) {
        let openFile = `mpv "${value.video}"`;
        for (const audio of value.audio) {
            openFile += ` --audio-file="${audio}"`
        }
        for (const subtitle of value.subtitles) {
            openFile += ` --sub-file="${subtitle}"`
        }
        if (fontDir) {
            openFile += ` --sub-fonts-dir="${fontDir}"`
        }
        const bashScriptPath = path.join(rootDIr, `${key}.bash`);
        await fs.writeFile(path.join(rootDIr, `${key}.bash`), openFile, 'utf8');
        await fs.chmod(bashScriptPath, 0o755);
    }
}

main().catch(err => {
    console.error('Failed to write directory structure:', err);
});
