import {compat, types as T} from "../deps.ts";

export const getConfig: T.ExpectedExports.getConfig = compat.getConfig({
    password: {
        type: "string",
        name: "Password",
        description: "Password for logging into your Sshwifty service.",
        nullable: false,
        copyable: true,
        masked: true,
        default: {
            charset: "a-z,A-Z,0-9",
            len: 21
        }
    },
    hackerMode: {
        type: "boolean",
        name: "Hacker Mode",
        description: "Toggle to send all traffic via the Tor network.<br><b>Note</b>: Once this mode is enabled, local connections to StartOS will not be available.",
        default: false
    }
});
