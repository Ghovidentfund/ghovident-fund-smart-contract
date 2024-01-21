import hre, { ethers } from "hardhat";
import addressUtils from "../../utils/addressUtils";

export async function deployGhovidentFund() {
  const aavePoolAddress = "0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951";
  const ghovidentFund = await ethers.deployContract("GhovidentFund", [
    aavePoolAddress,
  ]);

  await ghovidentFund.waitForDeployment();

  await addressUtils.saveAddresses(hre.network.name, {
    GhovidentFund: await ghovidentFund.getAddress(),
  });
}
