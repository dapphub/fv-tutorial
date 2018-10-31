Contains example formal verification problems for devcon4 workshop.

These practice problems are meant to be analysed using [klab](https://github.com/dapphub/klab). They may be faulty in different ways - the contracts may contain bugs or unintended behaviour, the specifications may be non-exhaustive or have assumptions missing.

Run `klab build` in one of the example folders to generate the specification claims and explore them by running `klab run --spec out/specs/NAME-OF-SPEC`. To recompile the contracts and explore the new behaviour, you will need [solc](http://github.com/ethereum/solidity). An easy way to install `solc` is using the `nix` package manager:
```bash
curl https://nixos.org/nix/install | sh
nix-env -i solc
```
Recompile contracts by running
```bash
solc --combined-json=abi,bin,bin-runtime,srcmap,srcmap-runtime,ast ./src/token.sol > ./out/token.sol.json
```
in the examples `dapp` folder.

A good thing to keep in mind during this tutorial is that proof claims that are incorrect fail with dubious errors from K. The best way to debug failing specs is to look at the branches explored, using klab and make sure to add constraints to not explore unintended execution paths.

Example solutions are found at the hidden repository [fv-tutorial-solutions](https://github.com/dapphub/fv-tutorial-solutions)
