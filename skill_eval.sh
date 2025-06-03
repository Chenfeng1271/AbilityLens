skill=$1
model=$2




export HF_TOKEN='' # your HF key
export HF_HOME="" #  your HF cache path




# Set tasks based on the skill
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

# Set pretrained model based on model type
if [ "$model" = "llava7b" ]; then
    model_v='llava'
    pretrained_model="liuhaotian/llava-v1.5-7b"
elif [ "$model" = "llava13b" ]; then
    model_v='llava'
    pretrained_model="liuhaotian/llava-v1.5-13b"
fi


echo "pretrained model is $pretrained_model"

for task in "${tasks[@]}"; do
    echo "Processing task: $task"


   python3  lmms_eval/__main__.py \
      --model $model_v \
      --skill $skill  \
      --verbosity=DEBUG \
      --model_args pretrained=$pretrained_model \
      --tasks $task \
      --batch_size 1 \
      --log_samples \
      --trust_remote_code \
      --log_samples_suffix  $model_v \
      --output_path  /logs/$model_v/$skill


done



