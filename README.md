
# AbilityLens: Evaluating and Advancing Multimodal Large Language Models in Perception Ability Lens




## Why `AbilityLens`?

<p align="center" width="80%">
<img src="![image](![image](https://github.com/Chenfeng1271/AbilityLens/blob/main/asset/pipeline.pdf)
)
"  width="100%" height="80%">
</p>


As multimodal large language models (MLLMs) advance rapidly, rigorous evaluation has become essential, providing further guidance for their development. In this work, we focus on a unified and robust evaluation of vision perception abilities, the foundational skill of MLLMs. We find that existing perception benchmarks, each focusing on different question types, domains, and evaluation metrics, introduce significant evaluation variance, complicating comprehensive assessments of perception abilities when relying on any single benchmark. To address this, we introduce  AbilityLens, a unified benchmark designed to evaluate MLLMs in six key perception abilities (ranging from counting, OCR, to understanding structural data), focusing on both accuracy and stability, with each ability encompassing diverse types of questions, domains, and metrics.
With the assistance of AbilityLens, we: (1) identify the strengths and weaknesses of current main-stream MLLMs, highlighting stability patterns and revealing a notable performance gap between state-of-the-art open-source and closed-source models; (2) uncover interesting ability conflict and early convergence phenomena during MLLM training; (3) reveal the primary reason of ability conflict is data mixing ratio and LLM model size; and (4) discuss the effectiveness of some straightforward strategies \eg, fine-tuning and model merging, to solve the ability conflict.

## Installation



For development, you can install the package by cloning the repository and running the following command:
```bash
git clone https://github.com/Chenfeng1271/AbilityLens
cd lmms-eval
pip install -e .
```

or you can directly run the bash to prepare environment
```bash
bash prepare_env.sh
```

If you want to test LLaVA, you will have to clone their repo from [LLaVA](https://github.com/haotian-liu/LLaVA) and
```bash
# for llava 1.5
# git clone https://github.com/haotian-liu/LLaVA
# cd LLaVA
# pip install -e .

# for llava-next (1.6)
git clone https://github.com/LLaVA-VL/LLaVA-NeXT
cd LLaVA-NeXT
pip install -e .
```


If you want to test [VILA](https://github.com/NVlabs/VILA), you should install the following dependencies:

```bash
pip install s2wrapper@git+https://github.com/bfshi/scaling_on_scales
```

For any installation issues, you can refer the [lmmms-eval](https://github.com/EvolvingLMMs-Lab/lmms-eval) repo.

## Ability Eval Usages


Our AbilityLens mainly focuses on six abilities, including Counting, OCR, Grounding, Entity, Attribute, and Structured Data Understanding. Each ability has multiple subtasks:

```bash
if [ "$skill" = "count" ]; then
    tasks=('seedbench_lite' 'mirb' 'mme' 'mmstar' 'muirbench')  
elif [ "$skill" = "ocr" ]; then
    tasks=('mme' 'ocrbench' 'synthdog_en' 'mmbench_en_dev')   
elif [ "$skill" = "grounding" ]; then
    tasks=('seedbench_lite' 'mmbench_en_dev_lite' 'mme' 'mmstar' 'muirbench')  
elif [ "$skill" = "attribute" ]; then
    tasks=('mmbench_en_dev_lite'  'seedbench_lite' 'mmstar' 'muirbench')   
elif [ "$skill" = "entity" ]; then
    tasks=('mmbench_en_dev_lite' 'mme'  'seedbench_lite')  
elif [ "$skill" = "structured_data" ]; then
    tasks=('chartqa_lite' 'ai2d_lite' 'mmbench_en_dev_lite' 'seedbench_lite' 'mmstar')  
fi
```

For each model, you can evaluate the model with

```bash
   python3  lmms_eval/__main__.py \
      --model $model \
      --skill $skill  \
      --verbosity=DEBUG \
      --model_args pretrained=$pretrained_model \
      --tasks $task \
      --batch_size 1 \
      --log_samples \
      --trust_remote_code \
      --log_samples_suffix  $model \
      --output_path  /logs/$model_v/$skill
```

You can adjust the parallel process for small models using deepspeed.

**For other variants llava. Please change the `conv_template` in the `model_args`**

> `conv_template` is an arg of the init function of llava in `lmms_eval/models/llava.py`, you could find the corresponding value at LLaVA's code, probably in a dict variable `conv_templates` in `llava/conversations.py`



### Supported models

Please check [supported models](lmms_eval/models/__init__.py) for more details.


## Add Customized Model and Dataset

Please refer to our [documentation](docs/README.md).

## Acknowledgement

AbilityLens is a fork of [lmms-eval](https://github.com/EvolvingLMMs-Lab/lmms-eval) and [lm-eval-harness](https://github.com/EleutherAI/lm-evaluation-harness). We recommend you to read through the [docs of lmms-eval](https://github.com/EvolvingLMMs-Lab/lmms-eval/tree/main/docs) for relevant information. 





## Citations

```shell
@article{chen2024evaluating,
  title={Evaluating and Advancing Multimodal Large Language Models in Ability Lens},
  author={Chen, Feng and Gou, Chenhui and Liu, Jing and Yang, Yang and Li, Zhaoyang and Zhang, Jiyuan and Sun, Zhenbang and Zhuang, Bohan and Wu, Qi},
  journal={arXiv preprint arXiv:2411.14725},
  year={2024}
}
```
