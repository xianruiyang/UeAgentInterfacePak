# Authoring Registry Contract

The UAI authoring registry has one declaration source:

`Source/UeAgentInterface/Private/Utilities/AuthoringCore/authoring_registry_source.hjson`.

Each domain's `RegisterAuthoring` root registers its descriptors, Apply contracts, Export contracts and providers, then consumes that domain's generated registration through `UeAgentAuthoringDomainRegistry::RegisterGeneratedDomain`. Domain export entry points must not perform lazy registration.

## Generated artifacts

Run:

```powershell
python.exe UeAgentInterfaceCMD/scripts/generate_authoring_registry_snapshot.py
```

The generator validates unique domain IDs and catalog kinds, validates each binding against its domain contracts, and writes:

- the C++ registration projection `UeAgentAuthoringRegistryGenerated.inl`;
- the canonical `authoring_registry_snapshot.hjson` on Dev, CLI, Pak and installed-skill surfaces;
- `generated_from.registry_hash` provenance in the CLI command-folder registry.

Generated files are not independent authoring sources and must not be edited by hand.

## Direction boundaries

Every snapshot domain contains separate `apply_contract` and `export_contract` objects. Their hashes are computed from separate canonical projections. Changing one direction must not change the other direction's hash unless that direction's declarations also changed.

`registry_hash` covers the complete registry payload: domain contracts, catalog bindings and the CLI seed contract.

## Consumers

- Palette Search resolves authoring placement only through `UeAgentAuthoringDomainRegistry::FRegistry::FindCatalogBinding`.
- CLI seed validation reads `registry.seed_contract` from the generated snapshot.
- Command-folder metadata records the snapshot registry hash.
- Automation tests compare the snapshot domain and contract sets with the live runtime registries.

Unknown catalog kinds remain non-authoring results. A declared binding whose contracts fail registration is a startup registration error; it must not fall back to a local mapping.

