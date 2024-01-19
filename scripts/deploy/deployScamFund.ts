import hre, { ethers } from "hardhat";
import addressUtils from "../../utils/addressUtils";

export async function deployScamFund() {
  const scamFund = await ethers.deployContract("ScamFund");

  await scamFund.waitForDeployment();

  await addressUtils.saveAddresses(hre.network.name, {
    ScamFund: await scamFund.getAddress(),
  });
}
