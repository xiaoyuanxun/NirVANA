import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
const PRIVATE_KEY = process.env.PRIVATE_KEY as string;
const INFURA_API_KEY = process.env.INFURA_API_KEY;

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [PRIVATE_KEY],
      gas: 2100000,
      gasPrice: 8000000000,
    },
    scrollAlpha: {
      url: "https://alpha-rpc.scroll.io/l2",
      accounts: [PRIVATE_KEY],
      gas: 2100000,
      gasPrice: 8000000000,
    },
  },
};

export default config;