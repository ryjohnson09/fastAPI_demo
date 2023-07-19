from fastapi import FastAPI, Query
from typing import List
import pandas as pd

app = FastAPI()


# Mock data
large_df = pd.read_csv("data.csv",  index_col=0)


@app.get("/data")
async def get_filtered_data(Letters: List[str] = Query(default=None)):
    if Letters:
        filtered_df = large_df[large_df["Letters"].isin(Letters)]
        return filtered_df.to_dict(orient="records")
    else:
        return large_df.to_dict(orient="records")