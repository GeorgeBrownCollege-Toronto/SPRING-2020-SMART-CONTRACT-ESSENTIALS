async function main() {
  const MimTestnet = await hre.ethers.getContractFactory("MimTestnet");
  const nft = await MimTestnet.deploy();

  await nft.deployed();

  console.log("MimTestnet deployed to:", nft.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
