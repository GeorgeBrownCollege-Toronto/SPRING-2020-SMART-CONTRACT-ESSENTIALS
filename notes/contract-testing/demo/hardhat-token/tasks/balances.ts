import {Signer} from "@ethersproject/abstract-signer";
import {task} from "hardhat/config";

import {TASK_BALANCES} from "./task-names";

task(TASK_BALANCES,"Print the balances of the accounts", async (_taskArgs, hre) => {
    const accounts: Signer[]  = await hre.ethers.getSigners();

    for(const account of accounts) {
        const address = await account.getAddress();
        console.log(address, await hre.ethers.provider.getBalance(address))
    }
})