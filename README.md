# Rails, Docker, PostgreSQL Appointment Scheduler (Backend Only)

## Overview

This is a backend framework for a doctor's office appointment scheduler. I created it with the following goals in mind:


1. Seed database by creating 10 doctors, who each have 10 patients, who each have 10 appointments. Names must be unique.
2. Create api/appointments endpoint to return all appointments.
3. Make appointments endpoint responsive to query params: **?past=1**, **?past=0**, and **?length=5&page=1**.
4. Create api/doctors endpoint to return all doctors without appointments.
5. Add POST to api/appointments


### Quickstart instructions

This repo requires the use of Docker.

Download repo, `cd` into main directory, then run `make build`, `make dbcreate`, and finally, `make up` to launch app in Docker.

Run `make bash` or use Docker's terminal feature to enter the app's container, and `rails db:seed` to seed the database.

JSON data can then be viewed at **localhost:3000/api/[appointments or doctors]**.

To test with Postman:

**localhost:3000/api/appointments**

`GET` returns appointments in this format:

```json
[
    {
        "id": 48330,
        "created_at": "2022-08-19T18:40:22.069Z",
        "start_time": "2023-05-28T09:00:00.000Z",
        "duration_in_minutes": 50,
        "patient": {
            "name": "Mitch Metz"
        },
        "doctor": {
            "id": 469,
            "name": "Elisabeth Donnelly"
        }
    }, ...
]
```

`POST` can be tested with the following. Note that `POST` requires valid doctor and patient ids.

```json
{
  "appointment": {
    "doctor_id": 437,
    "patient_id": 4249,
    "start_time": "2021-02-03T12:00:00+00:00Z",
    "duration_in_minutes": 50
  }
}
```

**localhost:3000/api/doctors**

`GET` returns available doctors in the following format. To add an available doctor, modify the seed script to uncomment that section.

```json
[
  {
    "id": 487,
    "name": "Available Doctor",
    "created_at": "2022-08-19T19:04:21.354Z",
    "updated_at": "2022-08-19T19:04:21.354Z"
  }
]
```

## Requirement 1

Any time a problem requires X items to each have Y properties, nested loops come to mind. The downside of a nested loop is O(n<sup>2</sup>) time complexity. Adding to the complexity in this case is the number of operations needed to ensure names and dates are unique. Faker's `.unique` method prefix stores created values and checks all new values against this data.

My first attempt to seed the database was to use several nested loops with Faker. I wasn't happy with the results however, because appointments could overlap. The generated times were also too random, for example, 1:22 AM.

To prevent overlapping appointments, I used the `patient_index` variable as that patient's appointment `start_time`. A few hours were added to make the data more realistic.

In this way, **Patient 3** of **Doctor 1** always has an appointment time of 10:00 AM, because their `patient_index` is 2, and eight hours are added. **Patient 4** of the same doctor will have an appointment at 11:00 AM, and so on.

The script still has a lot of operations, however it is important to generate data that closely resembles production to reduce the likelihood of bugs. As this is not customer-facing, I felt the tradeoff was worth it.

Tests for the script can be found at **spec/db/seeds_spec.rb**

## Requirement 2

I first used scaffolding to create this endpoint. However, I felt this created a lot of code that I wasn't going to need. I used the scaffolded endpoint as a guide to create the parts I needed manually.

I wanted to use **Active Model Serializer** to give the response the exact structure that I needed. However, I wasn't able to get it working in my environment, and so I used the default Rails approach instead.

## Requirement 3

Rails stores query parameters in a hash called params. To check for these params, I can use `if ... else` statements for each param. They are nested to prevent conflicts and allow multiple params at once.

## Requirement 4

I created an `available_doctors` variable and assigned it to all doctors who have no appointments.

## Requirement 5

This was created in the same way as **Requirement 2**, by using scaffolded endpoints as a guide to how routing and endpoints work in Rails.
