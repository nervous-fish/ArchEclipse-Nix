import { execAsync } from "astal"

export function handleRequest(req : string, res: Function) {
    switch (req) {
        case "init-wallpapers":
            execAsync("bash ./scripts/init-wallpapers.sh");
            break;
        case "set-global-theme":
            execAsync("bash ./scripts/set-global-theme.sh");
            break;
        default:
            break;
    }
}