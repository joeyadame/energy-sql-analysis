"""
Lightweight EIA retail sales extraction script.

Goal:
Pull monthly electricity retail sales data from the EIA API and convert the
response into a pandas DataFrame for downstream analysis or CSV export.

Usage examples:

    export EIA_API_KEY="your_api_key"
    python python/extract_retail_sales.py --preview

    export EIA_API_KEY="your_api_key"
    python python/extract_retail_sales.py --out data/retail_sales_extract.csv
"""

from __future__ import annotations

import argparse
import os
from pathlib import Path
from typing import Any


BASE_URL = "https://api.eia.gov/v2/electricity/retail-sales/data/"
DEFAULT_LENGTH = 5000
DEFAULT_STATE_IDS = [
    "AK",
    "AL",
    "AR",
    "AZ",
    "CA",
    "CO",
    "CT",
    "DE",
    "FL",
    "GA",
    "HI",
    "IA",
    "ID",
    "IL",
    "IN",
    "KS",
    "KY",
    "LA",
    "MA",
    "MD",
    "ME",
    "MI",
    "MN",
    "MO",
    "MS",
    "MT",
    "NC",
    "ND",
    "NE",
    "NH",
    "NJ",
    "NM",
    "NV",
    "NY",
    "OH",
    "OK",
    "OR",
    "PA",
    "RI",
    "SC",
    "SD",
    "TN",
    "TX",
    "UT",
    "VA",
    "VT",
    "WA",
    "WI",
    "WV",
    "WY",
]


def build_params(
    api_key: str,
    state_ids: list[str],
    sector_id: str,
    length: int,
) -> list[tuple[str, str]]:
    """Build ordered query parameters for the EIA retail sales endpoint."""
    params: list[tuple[str, str]] = [
        ("api_key", api_key),
        ("frequency", "monthly"),
        ("data[0]", "customers"),
        ("data[1]", "price"),
        ("data[2]", "revenue"),
        ("data[3]", "sales"),
        ("facets[sectorid][]", sector_id),
    ]

    for state_id in state_ids:
        params.append(("facets[stateid][]", state_id))

    params.extend(
        [
            ("sort[0][column]", "period"),
            ("sort[0][direction]", "desc"),
            ("offset", "0"),
            ("length", str(length)),
        ]
    )
    return params


def fetch_eia_data(
    api_key: str,
    state_ids: list[str],
    sector_id: str,
    length: int,
) -> dict[str, Any]:
    """Request retail sales data from the EIA API."""
    try:
        import requests
    except ModuleNotFoundError as exc:
        raise ModuleNotFoundError(
            "Install python/requirements.txt before running the extraction script."
        ) from exc

    response = requests.get(
        BASE_URL,
        params=build_params(api_key, state_ids, sector_id, length),
        timeout=60,
    )
    response.raise_for_status()
    payload = response.json()

    if "response" not in payload:
        raise ValueError("EIA API payload did not include a 'response' object.")

    if "data" not in payload["response"]:
        raise ValueError("EIA API response object did not include a 'data' field.")

    return payload


def payload_to_dataframe(payload: dict[str, Any]) -> Any:
    """Convert EIA response records to a pandas DataFrame."""
    try:
        import pandas as pd
    except ModuleNotFoundError as exc:
        raise ModuleNotFoundError(
            "Install python/requirements.txt before converting the payload to a DataFrame."
        ) from exc

    records = payload["response"]["data"]
    frame = pd.DataFrame(records)

    if frame.empty:
        raise ValueError("The EIA API returned an empty dataset.")

    return frame


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Extract monthly EIA retail sales data into a pandas DataFrame."
    )
    parser.add_argument(
        "--out",
        help="Optional CSV output path.",
    )
    parser.add_argument(
        "--state",
        action="append",
        dest="states",
        help="Optional state abbreviation filter. Use more than once to pass multiple states.",
    )
    parser.add_argument(
        "--sector",
        default="ALL",
        help="Optional EIA sector id filter. Defaults to ALL.",
    )
    parser.add_argument(
        "--length",
        type=int,
        default=DEFAULT_LENGTH,
        help=f"Maximum number of records to request. Defaults to {DEFAULT_LENGTH}.",
    )
    parser.add_argument(
        "--preview",
        action="store_true",
        help="Print a small preview of the extracted data.",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    api_key = os.getenv("EIA_API_KEY")

    if not api_key:
        raise EnvironmentError("Set the EIA_API_KEY environment variable first.")

    state_ids = [state.upper() for state in (args.states or DEFAULT_STATE_IDS)]
    payload = fetch_eia_data(api_key, state_ids, args.sector, args.length)
    frame = payload_to_dataframe(payload)

    print(f"Records returned: {len(frame)}")
    print(f"Columns returned: {', '.join(frame.columns)}")

    if args.preview:
        print(frame.head(10).to_string(index=False))

    if args.out:
        output_path = Path(args.out)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        frame.to_csv(output_path, index=False)
        print(f"Saved extract to {args.out}")


if __name__ == "__main__":
    main()
