import hre, { ethers } from "hardhat";
import addressUtils from "../../utils/addressUtils";

export async function deployBananaFund() {
  const aavePoolAddress = "0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951";
  const bananaFund = await ethers.deployContract("BananaFund", [
    aavePoolAddress,
  ]);

  await bananaFund.waitForDeployment();

  await addressUtils.saveAddresses(hre.network.name, {
    BananaFund: await bananaFund.getAddress(),
  });
}
