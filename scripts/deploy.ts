import { deployGhovidentFactory } from "./deploy/deployGhovidentFactory";

async function main() {
  await deployGhovidentFactory();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
