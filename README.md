<h1 align="center">moziOS</h1>
<h4 align="center">
An experimental project exploring the possibilities of a composable, self-programmable, and self-evolving operating system based on artificial intelligence.
<br/>
Inspired by &#12298;The Wandering Earth&#12299;
</h4>
<p align="center">
  <a href="https://github.com/0xhappyboy/candleview/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-AGPL3.0-d1d1f6.svg?style=flat&labelColor=1C2C2E&color=BEC5C9&logo=googledocs&label=license&logoColor=BEC5C9" alt="License"></a>
</p>
<p align="center">
<a href="./README_zh-CN.md">简体中文</a> | <a href="./README.md">English</a>
</p>

# moziOS · Core Philosophy

## Principle 1: The Kernel Must Remain Minimal and Non-Growing

**If a feature does not strictly belong in the kernel, it must not be placed in the kernel.**

The kernel is responsible only for:

- Isolation
- Scheduling
- Memory management
- IPC
- Device discovery

Any code outside these responsibilities entering the kernel is a design failure.

---

## Principle 2: Drivers Are Not Part of the Kernel

**Drivers must be ordinary services that can be terminated, replaced, and restarted.**

moziOS does not support:

- Kernel modules
- Non-unloadable drivers
- Device code bound to the kernel lifecycle

A driver crash must never imply a system crash.

---

## Principle 3: Compatibility Is Not a Goal

**moziOS does not exist to preserve historical mistakes, de facto standards, or market inertia.**

If compatibility:

- Permanently increases complexity
- Pollutes kernel abstractions
- Introduces unverifiable behavior

It shall be explicitly rejected.

---

## Principle 4: Mechanisms Over Policies

**The kernel provides mechanisms, not policies.**

- The kernel does not decide which driver is “best”
- The kernel does not perform optimization choices
- The kernel contains no business logic

All policies belong to user space, orchestration layers, or AI systems.

---

## Principle 5: Ownership Must Be Explicit

**Every resource must have a single, traceable owner.**

Including but not limited to:

- Memory pages
- Device access rights
- Interrupts
- DMA regions

No implicit sharing. No default access.

---

## Principle 6: State Must Be Destroyable

**Any state that cannot be fully destroyed is technical debt.**

- Driver state must be resettable
- Device state must be reclaimable
- Services must support cold restarts

The system must assume:
**Everything will fail, and recovery must be possible.**

---

## Principle 7: Abstractions Must Reflect Real Boundaries

**There are no abstractions that exist solely for elegance.**

Every abstraction must correspond to at least one real boundary:

- Address space
- Permissions
- Lifecycle
- Fault domain

Otherwise, the abstraction must be removed.

---

## Principle 8: System Behavior Must Be Explainable

**All critical decisions must be explainable, replayable, and auditable.**

Including:

- Driver matching
- Resource allocation
- Device orchestration

Black-box behavior is unacceptable at the kernel level.

---

## Principle 9: The System Is Indifferent to Devices and Technological Change

**moziOS does not care what a device is, nor does it care about technological evolution.**

The kernel does not encode:

- Device identity
- Hardware generations
- Vendor-specific knowledge
- Assumptions about future technology

Devices are treated only as:

- Capability providers
- Resource endpoints
- Event sources

Technological innovation must not require kernel evolution.  
Only new descriptions, components, or orchestration logic may change.

---

## Principle 10: Complexity Must Always Pay Rent

**Any added complexity must provide proportional long-term maintainability gains.**

If a feature:

- Increases complexity
- Does not reduce long-term maintenance cost
- Cannot be automated, orchestrated, or reasoned about

It does not belong in the system.

---

> **moziOS does not aim to support everything.  
> It exists to reject everything unnecessary.**

# Docker Compose

```
docker-compose up --builde
```
