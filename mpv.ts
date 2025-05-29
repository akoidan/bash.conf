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
            if (!entry.name.endsWith('.mkv') && !entry.name.endsWith('.ass') && !entry.name.endsWith('.mka')) {
                console.error(`Unkown file ${entry.name}`);
            }
            let regExpMatchArray = entry.name.match(/\d\d/);
            if (!regExpMatchArray) {
                console.error(`file ${entry.name} doesn't have epoisode #`);
                continue
                // throw new Error(`${entry.name} is not a file`);
            }
            const episode = parseInt(regExpMatchArray![0], 10);
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

async function main() {
    const rootDIr = "/home/andrew/ntfs/movies/No Game No Life TV/";
    await readDirRecursive( path.resolve(rootDIr));
    for (const [key, value] of Object.entries(structure)) {
        if (!value.video) {
            continue
            throw Error(`Cannot find main file for epise ${key}`);
        }
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
        const bashScriptPath = path.join(rootDIr, `${String(key).padStart(2, '0')}.bash`);
        await fs.writeFile(bashScriptPath, openFile, 'utf8');
        await fs.chmod(bashScriptPath, 0o755);
    }
}

main().catch(err => {
    console.error('Failed to write directory structure:', err);
});
