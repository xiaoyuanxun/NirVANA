const newWallet = ethers.Wallet.createRandom();
console.log(newWallet._signingKey().privateKey, newWallet.address);
