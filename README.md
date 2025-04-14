# Symbolic Runtime Verification and Adaptive Decision-Making for Robot-Assisted Dressing

We present a control framework for robot-assisted dressing that augments low-level hazard response with runtime monitoring and formal verification. A parametric discrete-time Markov chain (pDTMC) models the dressing process, while Bayesian inference dynamically updates this pDTMC's transition probabilities based on sensory and user feedback. Safety constraints from hazard analysis are expressed in probabilistic computation tree logic, and symbolically verified using a probabilistic model checker. We evaluate reachability, cost, and reward trade-offs for garment-snag mitigation and escalation, enabling real-time adaptation. Our approach provides a formal yet lightweight foundation for safety-aware, explainable robotic assistance.

<p align="center">
  <img src="https://github.com/user-attachments/assets/f432ae79-b267-44eb-8ab9-727b559a69ff" width="45%">
</p>

## GitHub repo structure

The pDTMC model is available in the [model folder](https://github.com/Gricel-lee/RAD-RuntimeVerification/tree/main/model).
