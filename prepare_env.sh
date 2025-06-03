
pip install -e .

cd LLaVA-NeXT   # your test model path
pip install -e .

cd  ..
pip install flash-attn==2.6.3 --no-build-isolation
pip install Levenshtein
pip install open_clip_torch
pip install accelerate
pip install anls
pip install qwen-vl-utils
pip install anthropic
pip install -U transformers
pip install FlagEmbedding, ipdb
pip install tf-keras
pip install rouge
pip install  langchain_community
pip install  playwright
pip install -q -U google-generativeai
