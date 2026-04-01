import pandas as pd

# Load the dataset you downloaded from GitHub
df = pd.read_csv("https://github.com/WalterPaci/IMPAQTS-PID/blob/main/data/IMPAQTS-PID.csv")

df.head()

# # 1. Extract the metadata from the filename into new columns
# df['speaker_code'] = df['IMPAQTS_file'].str[:4]
# df['year'] = df['IMPAQTS_file'].str[4:6]
# df['speech_type'] = df['IMPAQTS_file'].str[7:8]
# 
# # 2. Filter for a specific politician (e.g., MSAL for Matteo Salvini)
# salvini_df = df[df['speaker_code'] == 'MSAL']
# 
# # 3. Filter OUT parliamentary speeches (Type 'A')
# salvini_non_parliamentary = salvini_df[salvini_df['speech_type'] != 'A']
# 
# # Look at the results!
# print(salvini_non_parliamentary.head())