# Utility Scripts

## Setup

1. Install requirements.

> It is recommended to install packages in a virtual environment, such as with `virtualenv` or `pipenv`.

```bash
pip install pandas
pip install requests
```

1. Obtain API Key

Navigate to Campus -> Settings -> API Key. Create a new API Key, copy the value, and save it as you will need it for step 3.

3. Update script with API Key and Course Slug values. To view the course slug, navigate to your course and copy the course slug after the `.../courses/` part. From the value in the address bar. For example for:

```bash
https://uofmichigan.illumidesk.com/app/courses/rob101-fa-2024/lessons/activity/8c804205-e5d7-4640-8f88-8cdbfdaf5b23
```

The course slug is `rob101-fa-2024`.

## Fetch Submissions

1. Run the script to fetch student submissions:

```python
python fetch_course_submissions.py
```

2. A CSV file with the results will save to the same folder where you ran your script.
