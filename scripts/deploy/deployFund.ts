import hre, { ethers } from "hardhat";
import addressUtils from "../../utils/addressUtils";

export async function deployFund() {
  const fund = await ethers.deployContract("Fund");

  await fund.waitForDeployment();

  await addressUtils.saveAddresses(hre.network.name, {
    Fund: await fund.getAddress(),
  });
}
