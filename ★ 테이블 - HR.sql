-- 대륙
create table REGIONS (
    region_id varchar(100) primary key, -- 대륙번호??
    region_name varchar(100) -- 대륙이름
);

-- 국가
create table COUNTRIES (
    country_id varchar(100) primary key, -- 국가번호??
    country_name varchar(100), -- 국가이름
    region_id varchar(100), -- 지역이름
    foreign key (region_id)
    references REGIONS(region_id)
);

-- 위치
create table LOCATIONS (
    location_id varchar(100) primary key, -- 위치번호??
    street_address varchar(100),
    postal_code varchar(100),
    city varchar(100), -- 도시명
    state_province varchar(100),
    country_id varchar(100),
    foreign key (country_id)
    references COUNTRIES(country_id)
);

-- 부서
create table DEPARTMENTS (
    department_id varchar(100) primary key,
    department_name varchar(100), -- 부서명
    manager_id varchar(100), -- 상사번호
    location_id varchar(100),
    foreign key (location_id)
    references LOCATIONS(location_id)
);

-- 직업
create table JOBS (
    job_id varchar(100) primary key , -- 직무 아이디
    job_title varchar(100), -- 직무명
    min_salary varchar(100), -- 최대연봉
    max_salary varchar(100) -- 최소연봉
);

-- 사원
create table EMPLOYEES (
    employee_id varchar(100) primary key , -- 사원번호
    first_name varchar(100), -- 성
    last_name varchar(100), -- 이름
    email varchar(100), -- 이메일
    phone_number varchar(100), -- 휴대폰번호
    hire_date varchar(100), -- 고용날짜
    job_id varchar(100), -- 직무아이디, 직업, 담당업무
    salary varchar(100), -- 연봉, 급여
    commission_pct varchar(100), -- 인센티브
    manager_id varchar(100), -- 상사번호
    department_id varchar(100), -- 부서번호
    foreign key (department_id)
    references DEPARTMENTS(department_id),
    foreign key (job_id)
    references JOBS(job_id)
);


-- 직무 이력
create table JOB_HISTORY(
    employee_id varchar(100) primary key,
    start_date varchar(100),
    end_date varchar(100),
    job_id varchar(100), -- 직무 아이디
    department_id varchar(100),
    foreign key (job_id)
    references JOBS(job_id),
    foreign key (department_id)
    references DEPARTMENTS(department_id),
    foreign key (employee_id)
    references EMPLOYEES(employee_id)
);
