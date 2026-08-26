# T16 Animation Blueprint Domain

`content_graph.import_workspace` is the only public HJSON ingress. The
Animation Blueprint provider contributes `uai.animation_blueprint.edit/1` to
that shared owner and does not declare a domain apply command. Use the
read-only `animation.state_machine.candidates` command before creating a State
Machine or State, then pass only the selected `candidate.name` or
`candidate.id` into HJSON. Use `client.query.command_search(...)` and
`client.query.command_detail(...)` to inspect the live contract; the generated SDK
method is `client.animation.state_machine_candidates(...)`, and `uai-cli`
exposes the same discovery path. No task-specific helper or tutorial-owned
registry is authoritative.

The accepted schema is `uai.animation_blueprint.edit/1` with exact root type
`/Script/Engine.AnimBlueprint`. This revision supports a fully preflighted
`create` with `expected_revision="missing"`. Its provider extension contains
class settings, optional common Blueprint surfaces, animation graphs, and state
machines with states, entry state, and transitions.

Candidate discovery binds one future missing AnimBlueprint identity to the same
`class_settings` used by create. It creates a transient AnimBlueprint through
the same `UAnimBlueprintFactory`, opens no editor window, and exposes two exact
native surfaces:

- `surface="animation_graph"` enumerates the context-sensitive AnimGraph
  Blueprint Action Menu and invokes the same Blueprint node spawner. The exact
  `UAnimGraphNode_StateMachine` action is writable.
- `surface="state_machine_graph"` first creates a transient State Machine
  through that parent spawner, then enumerates
  `UAnimationStateMachineSchema::GetGraphContextActions`. Plain State is
  writable; Alias, Conduit, Comment and any other returned action stay
  search-only with explicit support fields.

`coverage_complete=true` means the claimed native surface was enumerated; it
does not mean every returned action is writable. Continue pagination while
`has_more=true`, prefer exact `id`, and inspect `supported`, `write_support` and
`support_reason`. If both candidate `name` and `id` are supplied they are a
conjunctive selector and must resolve the same action.

```hjson
provider_extension: {
  class_settings: {
    template: true
    parent_class: "/Script/Engine.AnimInstance"
  }
  state_machines: [{
    name: Locomotion
    animation_graph: AnimGraph
    candidate: { id: "candidate:<animation-graph-state-machine>" }
    pos_x: 320
    pos_y: 64
    states: [{
      name: Idle
      candidate: { id: "candidate:<state-machine-graph-state>" }
      pos_x: 240
      pos_y: 0
    }]
    entry_state: Idle
    transitions: []
  }]
}
```

Candidate identifies only the native action. Instance `name`, owning graph,
position, entry selection and transitions remain outside it. A known `class`
may be supplied only as an assertion; it cannot replace `name/id`. Transitions
are relations, not right-click candidates: T16 creates them through the native
State Machine schema connection path. The service re-enumerates and resolves
the candidate during transient preflight and again in the real graph before
the first persistent mutation.

Directory, `single_file`, and `inline` sources all pass through the shared
workspace loader, including manifest completeness, path/hash boundaries, and
exact entry-file resolution, before this provider executes. The provider is a
thin adapter over that shared HJSON lifecycle. T16 reuses the
verified T14 Blueprint members, components, graphs, nodes, pins, and edges. T13
is the sole common recursive initialization authority; T16 registers only the
Animation Blueprint-specific root, graph, state-machine, state, transition, and
class-setting contracts and consumes that seam. It does not duplicate parsing,
recursion, defaulting, reference binding, rollback, persistence, readback, or
cleanup.

Success is terminal only after normal Animation Blueprint compile and save,
package unload, reload, and independent readback containing class settings,
common Blueprint state, animation graphs, state machines, states, transitions,
generated class, and non-error compile status. Existing-target updates,
deletion, conduits, aliases, transition-rule graph authoring, layer interfaces,
and workspace export fail before persistent writes. The native catalog still
searches unsupported actions truthfully; their presence does not authorize
HJSON creation. The non-HJSON
`animation.anim_blueprint.*` commands remain with
`animation-blueprint-command-owner` and are not compatibility fallbacks.
