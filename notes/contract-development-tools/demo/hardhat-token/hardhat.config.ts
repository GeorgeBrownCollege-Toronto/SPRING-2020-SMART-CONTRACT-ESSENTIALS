/**
 * @type import('hardhat/config').HardhatUserConfig
 */
import { HardhatUserConfig } from 'hardhat/types';
import {config as dotenvConfig} from "dotenv";
import "@nomiclabs/hardhat-etherscan";
import {resolve} from "path";
import 'ethers';
import 'hardhat-deploy'
import 'hardhat-deploy-ethers'
import './tasks/accounts';
import './tasks/balances';

dotenvConfig({path:resolve(__dirname,"./.env")});

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  solidity: {
    version:'0.8.4',
  },
  networks: {
    ropsten: {
      url: `https://ropsten.infura.io/v3/${process.env.INFURA_ID}`,
      accounts:{
        "mnemonic":process.env.MNEMONIC,
        initialIndex:1
      }
    },
    hardhat:{
      chainId:1337,
      accounts:{
        "mnemonic":process.env.MNEMONIC,
        initialIndex:0
      }
    }
  },
  paths: {
    sources: "./contracts",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: process.env.ETHERSCAN_API_KEY
  }
}

export default config;