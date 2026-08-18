# Summary Model Comparison 

===== THINK OFF =====
model           gemma4-12b  gemma4-e4b  mistral-7b-v0.3  qwen2.5-7b  \
label                                                                 
aggressiveness       0.303       **0.476**            0.051       0.255   
hate_speech          0.228       0.168            0.128       0.173   
negativity           0.230       **0.293**            0.061       0.297   
target               0.722       0.674            0.699       0.705   

model           qwen3.5-4b  qwen3.5-4b-stock  qwen3.5-9b  
label                                                     
aggressiveness       0.194             0.363      -0.009  
hate_speech          0.091             0.268       0.037  
negativity           0.222             0.208       0.246  
target               0.783             0.760       0.721  

===== THINK ON =====
model           gemma4-e4b-THINK
label                     
aggressiveness       0.246
hate_speech          **0.538**
negativity           0.139
target               **0.869**
