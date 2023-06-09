import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import { config as dotEnvConfig } from "dotenv";
dotEnvConfig();
const PRIVATE_KEY = process.env.PRIVATE_KEY as string;
const INFURA_API_KEY = process.env.INFURA_API_KEY;
const NirVANA_API_KEY = process.env.NirVANA_API_KEY;

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },

  networks: {
    scrollAlpha: {
      url: "https://alpha-rpc.scroll.io/l2",
      accounts: [PRIVATE_KEY],
      gas: 2100000,
      gasPrice: 8000000000,
    },
  },
  etherscan: {
    apiKey: {
      scrollAlpha: NirVANA_API_KEY as string,
    },
    customChains: [
      {
        network: 'scrollAlpha',
        chainId: 534353,
        urls: {
          apiURL: 'https://blockscout.scroll.io/api',
          browserURL: 'https://blockscout.scroll.io/',
        },
      },
    ],
  },
};

export default config;