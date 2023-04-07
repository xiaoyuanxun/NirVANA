/* global ethers */
/* eslint prefer-const: "off" */
//@ts-nocheck

const {
    getSelectors,
    FacetCutAction,
    getRemovedSelectors,
    getRemovedSelectorsBySelector,
  } = require("./libraries/diamond.ts");
  
  async function deployDAO() {

    // 部署DAO
    const DAOFacet = await ethers.getContractFactory("DAOFacet");
    const daoFacet = await DAOFacet.deploy();
    await daoFacet.deployed();
    console.log(`DAOFacet deployed: ${daoFacet.address}`);

  }
  
  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
  if (require.main === module) {
    deployDAO()
      .then(() => process.exit(0))
      .catch((error) => {
        console.error(error);
        process.exit(1);
      });
  }
  
  exports.deployDAO = deployDAO;
  