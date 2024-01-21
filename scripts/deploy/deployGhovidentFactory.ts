import hre, { ethers } from "hardhat";
import addressUtils from "../../utils/addressUtils";

export async function deployGhovidentFactory() {
  const ghovidentFactory = await ethers.deployContract("GhovidentFactory");

  await ghovidentFactory.waitForDeployment();

  await addressUtils.saveAddresses(hre.network.name, {
    GhovidentFactory: await ghovidentFactory.getAddress(),
  });
}
