import { exec } from "astal";

export async function compileBinaries()
{
    exec(`gcc -o ${DATADIR}/ags/assets/binaries/bandwidth ./scripts/bandwidth.c`);
}