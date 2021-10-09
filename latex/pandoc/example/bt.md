---
title: Spatially Structured Recurrent Modules
subtitle: _- Paper review -_
date: 2021-09-29
author: \textsc{sam griesemer}
author-abbr: Sam Griesemer
institute: \textsc{\color{nred}university of southern california}
institute-abbr: USC
theme: "AnnArbor"
colortheme: "spruce"
fonttheme: serif
section-titles: false
navigation: horizontal
toc: true
toc-title: Contents
---

# Intro
## Subection

### Introduction (cont'd)
Want to forecast future state of a dynamical system; which scale do we operate at?

- Global scale captures all information, but interactions don't scale well with larger
  environments.
- Local scale captures dynamics in a small neighborhood, and sparsely interacting only
  with neighboring local subsystems. This can scale well to larger environments but makes
  the fundamental assumption that local short-term dynamics are only impacted by immediate
  neighbors, and could miss out on important long-range interactions across the
  environment.

#### A sub
With something to say


### Introduction (cont'd)
The spectrum of "resolution" here encodes a scale space of problem representation, a
continuum of tradeoffs.

We want to _learn_ a notion of locality instead of hinging on an existing one. Scale
ranges subjectively


# Problem
## Prob
### Problem
Environment dynamics model stated as

$$\phi : \mathbb{Z}\times\mathcal{O}_{\mathcal{X}} \mapsto \mathcal{O}_{\mathcal{X}}$$

### Recurrent dynamics
Typical RNN-based dynamics model

$$H_{t+1}=F(O_t,h_t) O_t=D(h_t)$$

We lean on our hidden state $h_t$


# Model
## Model
High-level framework goal: model sub-systems as independent RNNs, capable of interacting
sparsely via an attention bottleneck

1. Embed sub-systems in a topology and use a metric on this topology to encode the strength
  of interaction between embedded submodules.
2. In some ways mirrors [[Neural scene representation and rendering]] spatiotemporal setup


## Model specifics

![Local subsystem interaction](/home/smgr/Documents/notes/images/1632909030.png)


# Follow up ideas
## ideas
- dynamic kernel bounds submodule by submodule? Break imposed symmetry, could
  reflect even more flexibility through scales
- Or superimposing levels of thresholds on modules, have an intermediate layer, then finer
  layer that necessarily must be related to small sets of other modules or data points due
  to tighter threshold, then for larger threshold. Could tie inter-threshold embedding a
  together, learn jointly. Is this useful, or can single level do this on its own?


## Follow up ideas (cont'd)
- Simply re-project S onto new topology, learn set of interactions over initial space?
  Might embody a hierarchical notion, could keep projecting to new subspaces and learn
  more specialized submodules, finer locality
- Continuous notion of locality: the continuous extension from embedding where all su
  modules interact and have wide thresholds in interaction geometry, all the way down to
  super tight, only self inducing scope. You can sort of imagine a cloudy transition space
  in 3D between these two points, where the embedded modules move around and make small
  adjustments between finite differences between scales. Picture a flat 2D layout of nodes
  in a graph sort of deal, with kernel thresholds visualized. Then you pull that thin
  slice into 3D and can see tubes through the 3D geometry connecting nodes between
  different heights, merging and breaking arbitrarily. Interesting visual, not sure it
  leads to anything

