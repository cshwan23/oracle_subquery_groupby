------------------------------------------
--문1 employee 테이블에서 모든 칼럼의 데이터를 검색하면?
------------------------------------------
select emp_no, dep_no, jikup, salary, hire_date, jumin_num, phone_num from employee;
select * from  employee;

------------------------------------------
--<문2> employee 테이블에서 select emp_no, dep_no, jikup, salary, hire_date 칼럼의 데이터를 검색하면?
------------------------------------------
select emp_no, dep_no, jikup, salary, hire_date from employee;

------------------------------------------
--<문3> employee 테이블에서 select emp_no, dep_no, jikup, salary, hire_date 을 검색하면서
-- 컬럼의 별칭을 사원번호, 직원명, 직급, 연봉, 입사일로 하고 연봉에 만원이란 문자를 붙여 검색하면? (as 생략 가능)
------------------------------------------
select  emp_no "직원번호"
        , emp_name "직원명"
        , jikup "직급"
        , salary||'만원'as "연봉"
        , hire_date as "입사일"
from employee;

------------------------------------------
--<문4>** employee 테이블에서 직원명, 직급, 연봉, 세금을 검색하면? (세금은 연봉의 12%)
------------------------------------------
select
          emp_name as "직원명"
        , jikup as "직급"
        , salary||'만원' as "연봉"
        , salary*0.12||'만원' as "세금"
from employee;

------------------------------------------
--<문5> employee 테이블에서 직원명, 직급, 연봉, 실수령액을 검색하면? (세금은 연봉의 12%)
------------------------------------------
select
          emp_name as "직원명"
        , jikup as "직급"
        , salary||'만원' as "연봉"
        , salary*0.88||'만원' as "실수령액"
from employee;

------------------------------------------
--<문6> employee 테이블에서 직급을 중복 없이 검색하면?(방법 1.distinct, 2.unique 함수)
------------------------------------------
select distinct jikup as "직급" from employee;
select unique(jikup) as "직급" from employee;

------------------------------------------
--<문7>** employee 테이블에서 부서번호와 직급을 중복없이 검색하고 오름차순으로 정렬하려면?
------------------------------------------
select distinct dep_no "부서번호", jikup as "직급" from employee order by 1 asc;
-- select * from user_users;


------------------------------------------
--<문8>*** employee 테이블에서 연봉이 3000 이상인 직원을 검색하면?
------------------------------------------
    -- 행 골라내는 키워드 = where
    -- where 뒤에는 행을 골라내는 조건이 나온다.
    -- 오라클에선 == 이 없다.

select  * from employee where salary>=3000;
select  * from employee where salary=3000;

------------------------------------------
--<문9>** employee 테이블에서 연봉 오름차순으로 검색하면?
------------------------------------------
    --order by 는 행의 순서를 바꾸는 키워드다.
    --<참고> 만약 내림차순이라면 asc 대신 desc를 사용한다.
    --<참고> asc 생략이 가능하다.
    --<참고> order by 뒤에는 [칼럼명] 또는 [칼럼순서번호]또는 [알리아스]가 나온다
select * from employee order by salary asc;
select * from employee order by 5 asc;


------------------------------------------
--<문10>** employee 테이블에서 부서번호 오름차순 유지하면서 연봉 내림차순으로 검색하면?
------------------------------------------
    --<주의>아래 정답은 asc가 생략된 것이다.
    -- 그러다보니 맨 뒤에 desc가 앞에 나오는 모든 컬럼에 영향을 준 것처럼 보이나 아니다.
    ---------------------------------------
select *from employee order by dep_no asc, salary desc;

select *from employee order by dep_no , salary desc;

------------------------------------------
--<명심> 고객의 요구사항을 보고 select 문을 작성하는 것도 중요하지만 이미 작성된
--      select 문을 보고 고객의 요구 사항을 알아내는 것도 중요하다.
------------------------------------------

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 함수 문제
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
------------------------------------------
--<문제11> concat, initcap, lower, upper
------------------------------------------
select
    concat('Romeo','Juliet')
    ,concat('로미오', '줄리엣')
    ,'로미오'||'줄리엣'
    ,initcap('abCDefGHi')
    ,initcap('i am a boy')
    ,lower('abcdeFG')
    ,upper('abcdeFG')
from dual;
------------------------------------------
-- 듀얼은 존재하지 않는 더미 테이블, 테이블과 관계없이 출력시에만 사용한다.
------------------------------------------
--<문제12> lpad, rpad
------------------------------------------
select
    lpad('abc',7,' '),  --> abc (좌측에 공백 4개 있음)
    lpad('abc',7,'#'),  --> ####abc
    lpad('abc',7,'s'),  --> ssssabc
    rpad('abc',7,' '),  --> abc (우측에 공백 4개 있음)
    rpad('abc',7,'#'),  --> abc####
    rpad('abc',7,'s')   --> abcssss
from dual;
------------------------------------------
--<문제13> trim, ltrim, rtrim, length
------------------------------------------
select
    trim(leading 'A' from 'AABBCCDD'),  --from 절 뒤의 문자열에서 맨 앞이 A인 놈을 제거하고 리턴
    trim(trailing 'D' from 'AABBCCDD'), --from 절 뒤의 문자열에서 맨 뒤가 D인 놈을 제거하고 리턴
    trim(both 'A' from 'AABBCCDD'),     --from 절 뒤의 문자열에서 맨 앞뒤이 A인 놈을 제거하고 리턴
    trim('A' from 'AABBCCDD'),          --from 절 뒤의 문자열에서 맨 앞뒤이 A인 놈을 제거하고 리턴
    ltrim('ABCDEFG', ' '),              --문자열에서 맨 왼쪽의 공백을 계속 제거하고 리턴
    ltrim('ABCDEFG', 'AB'),             --문자열에서 맨 왼쪽의 A 또는 B를 제거하고 리턴
    ltrim('ABCDEFG', 'BC'),             --문자열에서 맨 왼쪽의 B 또는 C를 제거하고 리턴
    rtrim('ABCDEFG', ' '),              --문자열에서 맨 오른쪽의 공백을 계속 제거하고 리턴
    rtrim('ABCDEFG', 'FG'),             --문자열에서 맨 오른쪽의 F 또는 G를 제거하고 리턴
    rtrim('ABCDEFG', 'EF'),             --문자열에서 맨 오른쪽의 E 또는 F를 제거하고 리턴
    trim('ABCDEFG') ,                   --문자열에서 맨 왼쪽,오른쪽의 공백 제거하고 리턴 (제일많이쓰임)
    length(trim('ABCDEFG'))             --문자열에서 맨 왼쪽,오른쪽의 공백 제거하고 문자열의 길이 리턴
from dual;


------------------------------------------
--<문제14> 'You are not alone' 문자열에서 원하는 문자만 낚아채고 싶을 때(substr함수**)
------------------------------------------
    --substr(낚아챌대상,순서번호,낚아챌문자개수)
    ------------------------------------------
    --substr(낚아챌대상,순서번호) => 순서번호부터 뒤 끝까지 전부다 낚아챔
    ------------------------------------------
    --substr(낚아챌대상,-순서번호,낚아챌문자개수) => 맨뒤에서부터 순서번호부터 낚아챔
    ------------------------------------------
    --substr(낚아챌대상, 0 ,낚아챌문자개수) => 순서번호가 0이면 오라클이 1로 바꿔준다.
    ------------------------------------------
    --substr(낚아챌대상, 순서번호 ,0) => 낚아챌문자개수가 0이면 null이 출력된다.
    ------------------------------------------
select
    substr('You are not alone',9,3),   --> not
    substr('You are not alone',5),     --> are not alone
    substr('You are not alone',13,2),  --> al
    substr('You are not alone',-5,2),  --> al
    substr('You are not alone',-5,0)   --> null
from dual;

------------------------------------------
--<문제15>문자열을 다른 문자로 바꾸고싶을때 & 제거하고싶을때 (replace 함수)
------------------------------------------
    -- replace(찾을대상, 바꿀대상, 대체될데이터)
    --------------------------------------
    -- replace(찾을대상, 바꿀대상) -> ''길이가 없는걸로 대체하니까 제거의 의미가 된다.
    --------------------------------------
-- replace(찾을대상)
select
    replace('You are not alone', 'You','We'),   --> We are not alone
       -- 아래 셋다 제거의 의미
    replace('You are not alone', 'You'),        --> are not alone
    replace('You are not alone', 'You', null),  --> are not alone
    replace('You are not alone', 'You', '')     --> are not alone

from dual;
------------------------------------------
--translate (찾을대상, 바꿀대상, 대체될데이터)
------------------------------------------
    -- 바꿀대상의 순서번호와 대체될데이터의 순서번호와 매칭해서 대체된다.
    -- 'You' - 'We'
    -- Y -> W
    -- o -> e
    -- u -> '' 없으니 제거
select
    translate('You are not alone','You', 'We')  --> We are net alene
from dual;

------------------------------------------
--<문제16> 아스키코드값을 알고 싶을 때 (ascii)
------------------------------------------
    --instr (= js에서 indexOf랑 같음)
    ------------------------------------------
select
    ascii('A'),
    ascii('a'),
    ascii('AB'),
    instr('Every sha-la-la-la Every wo-wo-wo', 'la'),
    instr('Every sha-la-la-la Every wo-wo-wo', 'la',1),
    instr('Every sha-la-la-la Every wo-wo-wo', 'la',1,2)
from dual;

------------------------------------------
--<문제17> **** sign, round, trunc, ceil, floor, power, sqrt, mod
------------------------------------------
    -- sign  : 양수,음수,0 인지 확인하는 함수
    -- round : 반올림 하는 함수
    -- trunc : 무조건 버림
    -- ceil : 얘보다 크면서 가장 가까운 정수
    -- floor : 얘보다 작으면서 가장 가까운 정수
    -- power(n,m) : n의 m승(n을 m번 곱해라)
    -- sqrt(n) : 루트 n
    -- mod(n,m) : n을 m으로 나눈후 나머지 값
select
    sign(32),   -->1    sign(양의수)면 1리턴.
    sign(-32),  -->1    sign(음의수)면 -1리턴.
    sign(0),    -->1    sign(0)이면 0리턴.
---------------------------------------------------------------------------------
    round(0.62345678, 0),       -->1       round(숫자, 반올림한 후 보여지는 소수점 자리수)
    round(0.12345678, 0),       -->0       소수점 0+1번째자리에서 반올림해서 보여줘
    round(0.12345678, 3),       -->0.123   소수점3+1번째 자리에서 반올림해서 보여줘
    round(0.12345678, 4),       -->0.1235  소수점4+1번째 자리에서 반올림해서 보여줘
    round(1234.12345678, -2),   -->1200    정수 2째자리에서 반올림해서 보여줘.
---------------------------------------------------------------------------------
    trunc(1234.12345678, 0),    -->1234    소수점 0+1번째 자리를 버린후 보여줘라.
    trunc(1234.12345678, 2),    -->1234.12 소수점 2+1번째 자리를 버린후 보여줘라.
    trunc(1234.12345678, -2),   -->1200    정수 2번째부터 버린후 보여줘라.
---------------------------------------------------------------------------------
    ceil(1234.12345678),        -->1235
    ceil(0.12345),              -->1
---------------------------------------------------------------------------------
    floor(1234.12345678),       -->1234
    floor(0.12345),             -->0
---------------------------------------------------------------------------------
    power(3,2),                 -->9        3의2승(3을2번곱해라)
---------------------------------------------------------------------------------
    sqrt(2),                    -->1.414..  루트 2
---------------------------------------------------------------------------------
    mod(9,4)                    -->1        9를4로 나눴을 때의 나머지
from dual;


------------------------------------------
--<문제18> ******* 날짜 함수 ( 너무중요, DB 입장에서 날짜는 곧 돈이다.)
------------------------------------------
-- 1. add_months
------------------------------------------
    -- to_date('날짜문자','날짜패턴') --> 날짜문자를 진짜 날짜로 바꿈
    ------------------------------------------
    -- add_months(날짜, 더해지는 개월수) => 리턴값 =날짜
    ------------------------------------------
select
        ------------------------------------------
        -- Q. 2020년 10월 22일 기준 1개월 이후의 날짜는 언제냐?
        ------------------------------------------
        add_months(to_date('2020-10-22','YYYY-MM-DD'),1),

        ------------------------------------------
        -- Q. 2020년 1월 30일 기준 1개월 이후의 날짜는 언제냐?
        ------------------------------------------
        -- 2020년 2월 30일 이 없으므로 그달의 마지막날을 보여준다.
        add_months(to_date('2020-1-30','YYYY-MM-DD'),1),

        ------------------------------------------
        -- Q. 2020년 11월 30일 기준 1개월 이후의 날짜는 언제냐?
        ------------------------------------------
        -- 2020년 11월 30일은 11월의 마지막날이므로
        -- 한달 뒤인 12월의 마지막 날 즉 2020년 12월 31일을 보여준다.
        add_months(to_date('2020-11-30','YYYY-MM-DD'),1),

        ------------------------------------------
        -- Q. 오늘 부터 5개월 이후의 날짜는?
        ------------------------------------------
        -- sysdate 는 오늘 날짜를 의미함. 즉 현재 시스템 날짜를 의미함.
        add_months(sysdate,5)

from dual;

select

    ------------------------------------------
    -- Q. 오늘 날짜 부터 100일 이후 날짜는?
    ------------------------------------------
    sysdate+100 --> 날짜에 숫자를 더하면 일수만큼 더한 날짜가 나온다.

    ------------------------------------------
    -- Q. 나의 돌 날짜는?
    ------------------------------------------
    ,to_date('1990-02-03','YYYY-MM-DD')+100

    ------------------------------------------
    -- Q. 오늘 날짜에 20년 5개월 10일을 더한 후의 날짜는?
    ------------------------------------------
    ,add_months(sysdate+(365*20),5)+10
    ,add_months(sysdate,(12*20)+5)+10
    ,add_months(add_months(sysdate,12*20),5)+10

    ------------------------------------------
    -- Q. 태어난 날 이후 오늘까지 며칠이 흘렀을까?
    ------------------------------------------
     --날짜에서 날짜를 빼면 일수를 리턴한다.
     --오라클은 날짜에서 날짜를 빼는 전용함수가 없다. 그냥 빼면(-) 된다.
    ,sysdate-to_date('1990-02-03','YYYY-MM-DD')


    ------------------------------------------
    -- Q. 두 날짜의 차이를 일수가 아닌 월수로 구헤주는 함수
    ------------------------------------------
    -- 2. months_between
    ------------------------------------------
     --months_between(n,m) : n날짜-m날짜 두 날짜를 뺀 차이를 개월수로 리턴한다.
     -- <주의> 이때 리턴값은 날짜가 아니라 숫자다.
    ,months_between(sysdate ,to_date('1990-02-03','YYYY-MM-DD') )


    ------------------------------------------
    -- Q. 1990-02-03 이후 제일 빠른 월요일 날짜?
    ------------------------------------------
    -- 3. next_day(n,m)
    ------------------------------------------
    -- 특정 날짜(n) 이후로 특정요일(m)이 가장 빠른 날
    -- next_day(n,m) : n은 특정날짜, m은 요일숫자 (일요일은1 토요일은7)
    ,next_day(to_date('1990-02-03','YYYY-MM-DD'),2 )


    ------------------------------------------
    -- Q. 1990년 2월 3일이 속한 달의 마지막 날짜는 언제냐?
    ------------------------------------------
    -- 4. last_day
    ------------------------------------------
     --last_day(특정날짜) : 특정 날짜가 속한 달의 마지막 날짜를 구하는 함수
    ,last_day(to_date('1990-02-03','YYYY-MM-DD') )
    -- 이번달 마지막 날짜
    ,last_day(sysdate)

    ------------------------------------------
    -- Q. 오늘 날짜의 년도를 숫자로, 월을 숫자로, 일을 숫자로 출력하기
    ------------------------------------------
     -- 5. extract(n from m) : m의 특정날짜에서 n날짜 형식의 숫자로 구하는 함수
    ------------------------------------------
     --extract(year from 특정날짜)
     --extract(month from 특정날짜)
     --extract(day from 특정날짜)
    ,extract(year from sysdate )
    ,extract(month from sysdate )
    ,extract(day from sysdate )
     -- 다른 방법.
    ,to_number(to_char(sysdate,'YYYY'))
    ,to_number(to_char(sysdate,'MM'))
    ,to_number(to_char(sysdate,'DD'))


    ------------------------------------------
    -- Q. 오늘 날짜를 다양한 형태의 날짜문자로 바꾸기
    ------------------------------------------
    --    오늘 날짜를 년-월-일 로 출력하면 어떻게 해야하나?
    --             년-월 로 출력하면 어떻게 해야하나?
    --             년 으로 출력하면 어떻게 해야하나?
    --             일 로 출력하면 어떻게 해야하나?
    --             요일 로 출력하면 어떻게 해야하나?
    --             요일의 앞글자만(약어) 출력하려면 어떻게 해야하나?
    --             요일을 숫자로 출력하려면 어떻게 해야하나?(일-토,1-7이다)
    --             요일을 일본어로 출력하려면 어떻게 해야하나?
    --             요일을 영어로 출력하려면 어떻게 해야하나?
    --             분기로 출력하려면 어떻게 해야하나?
    --             (군대식) 시 분 초로 출력하려면 어떻게 해야하나?
    --             (사제식) 시 분 초로 출력하려면 어떻게 해야하나?
    --             (오전 오후 포함한)시 분 초로 출력하려면 어떻게 해야하나?
    ------------------------------------------
    ,to_char(sysdate,'YYYY-MM-DD')
    ,to_char(sysdate,'YYYY-MM')
    ,to_char(sysdate,'YYYY')
    ,to_char(sysdate,'DD')
    ,to_char(sysdate,'DAY')
    ,to_char(sysdate,'DY')
    ,to_char(sysdate,'D')
    ,to_char(sysdate,'DAY','NLS_DATE_LANGUAGE=Japanese')
    ,to_char(sysdate,'DAY','NLS_DATE_LANGUAGE=English')
    ,to_char(sysdate,'Q')
    ,to_char(sysdate,'YYYY/MM/DD HH24:MI:SS')
    ,to_char(sysdate,'YYYY/MM/DD HH:MI:SS')
    ,to_char(sysdate,'YYYY/MM/DD AM HH:MI:SS')

from dual;


----------------------------
-- 숫자를 다양한 형태의 문자로 바꾸기
----------------------------

----------------------------
-- Q1. 자리수를 지정하고 자리수가 남으면 앞에 0을 채우기
----------------------------
select
    to_char(1234,'099999')
    -->  9개 개수(자리수 5개 확보) 9앞에 0은 5(99999)자리수에 맞게 앞에 채운다.
    -->  만약 9앞에 0이 없다면 그 자리를 자른다(공백으로 채운다)
    -->> 5자리 확보하고 숫자 집어넣기. 9패턴 자리의 숫자는 있으면 내비두고 없으면 비우라 0패턴자리의 숫자는 있으면 내비두고 없으면 0을채우라
from dual;
----------------------------
-- Q2. 천단위로 콤마를 집어 넣어보자
----------------------------
select
    to_char(1234,'999,999')
-->>6자리 확보하고 3자리에 콤마(,)를 삽입하고 숫자 집어넣기.9패턴,0패턴은 위와 동일함
from dual;
----------------------------
-- Q3. 소수점 자리수를 확보해보자.
----------------------------
select
    to_char(1234,'99999.99') -- 정수자리 5자리 확보 소수점자리 2자리 확보
-->> 정수 5자리, 소수 2자리 확보하고 숫자 집어넣기 9패턴, 0패턴은 위워 동일함
from dual;
----------------------------
-- Q4. 정수자리에 0이라면 그 0을 지워버리기
----------------------------
select
    to_char(0.5,'999.99') --.50
--수학에서는 0밑의 숫자는 무조건 0이 들어가지만, 그 0을 지우기
from dual;

----------------------------
-- Q5. 정수자리에 숫자가 없다면, 정수 첫째자리에 0 하나는 넣어주기
----------------------------
select
    to_char(0.5,'990.99') --0.50
from dual;

----------------------------
-- Q6. 정수셋째짜리에 없으면 0이 들어가는데 그 다음에도 없다면 할수없이 0이 들어간다.
----------------------------
select
    to_char(0.5,'099.99') --000.50
from dual;

----------------------------
-- Q7. 맨앞에 $, ₩ 넣기
----------------------------
select
        to_char(1234,'$99,999.00'), -- $(달러)붙이기 패턴은 위와 동일
        to_char(1234,'L99,999.00'), -- L(Local 지역 통화 기호) 붙이기. 패턴은 위와 동일
        '$'||to_char(1234,'99,999.00'), -- 위와 같은 다른 방식
        '₩'||to_char(1234,'99,999.00') -- 위와 같은 다른 방식
from dual;

----------------------------
-- Q8. 숫자문자를 숫자로 바꾸기
----------------------------
select
        to_number('123456.9')
        --> 숫자문자 '123456.9를 계산 가능한 숫자로 바꾸기
from dual;

----------------------------
-- Q9. 콤마(패턴) 있는 숫자문자를 숫자로 바꾸기
----------------------------
select
       -- to_number에게 양해를 구하고 어떤 패턴인지 얘기를 해줘야한다.

        to_number('123,456.9', '999,999.9'),
       --> 숫자문자 '123,456.9'를 계산 가능한 숫자로 바꾸기.
       --> ,콤마는 문자이므로 2번째 인자에 패턴임을 명시한다.

        to_number('1,234,567.9', '9,999,999.9'),
       --> 숫자문자 '1,234,567.9'를 계산 가능한 숫자로 바꾸기.
       --> ,콤마는 문자이므로 2번째 인자에 패턴임을 명시한다.

        -- 콤마 대신에 G를 써도 똑같이 된다.(다른 방법)
        to_number('1,234,567', '9G999G999')

from dual;

----------------------------
-- 기타 함수( decode , case )
----------------------------

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q10. employee 테이블에서 직원번호, 직원명, **성별(주민번호 안)** 출력하기
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

-- decode 함수
----------------------------
-- decode()
----------------------------
select
       EMP_NO,
       EMP_NAME,
       -- decode( 작업대상 , 조건1, 실행문1 ,조건2, 실행문2, 실행문3 )
       -- 조건1을 인지하고 실행문1으로 변환하는것(조건문의 성격도 숨어있다)
       -- , 조건1 , 실행문1 (조건1이면 실행문1 실행)
       -- , 조건2 , 실행문2 (짝수)
       -- , 실행문3 (홀수) <-- 위 조건 외에 이면 실행문 3 을 실행.
       decode(substr(JUMIN_NUM,7,1)
           ,'1','남'
           ,'3','남'
           ,'여'
        )
from EMPLOYEE;

----------------------------
-- case 함수 (방법1)
----------------------------
-- case 작업대상 when 조건1 then 실행문1 when 조건2 then 실행문2 else 실행문3 end
----------------------------
-- 조건1이면 실행문1실행 조건2면 실행문2 실행 그외의 조건에는 실행문3 실행
----------------------------
select
       EMP_NO,
       EMP_NAME,

       case substr(JUMIN_NUM,7,1)
           when '1' then '남' when '3' then '남' else '여' end

from EMPLOYEE;

----------------------------
-- case 함수 (방법2)
----------------------------
-- case when 작업대상 = 조건1 then 실행문1
--      when 작업대상 = 조건2 then 실행문2
--      else 실행문3 end
----------------------------
-- 작업대상이 조건1이면 실행문1 실행
-- 작업대상이 조건2이면 실행문2 실행
-- 그 외의 조건에는 실행문3 실행
----------------------------

select
       EMP_NO,
       EMP_NAME,

       case
           when substr(JUMIN_NUM,7,1)='1' then '남'
           when substr(JUMIN_NUM,7,1)='3' then '남'

           else '여' end

from EMPLOYEE;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q11. employee 테이블에서 직원번호, 직원명, **월급등급** 출력하기
-- 월급등급 기준
-- 5000 이상이면 A급 4000~5000 이면 B급 3000~40000 이면 C급 2000~3000 이면 D급 0~2000 이면 F급
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
----------------------------------------
--  && 연산자는 oracle 에서 and 를 쓰면 된다.
----------------------------------------
select
       EMP_NO,
       EMP_NAME,

       case
           when SALARY>=5000 then 'A'
           when SALARY>=4000 and SALARY<5000 then 'B'
           when SALARY>=3000 and SALARY<4000 then 'C'
           when SALARY>=2000 and SALARY<3000 then 'D'
           when SALARY<2000 then 'F'
       end "연봉등급"

from EMPLOYEE;


----------------------------------------
-- 통계 관련 함수
----------------------------------------
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q12. employee 테이블에서 [최소 연봉], [최대 연봉], [평균 연봉], [연봉 총합], [총인원수]를 검색해서 출력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

-- (그룹 함수)
-- salary 안에 null이면 더할때도 빠지고 개수에도 빠진다 (null은 그룹함수에서 계산을 할때 아예 참여를 하지 않는다.)

select
    min(salary), max(salary), avg(salary), sum(salary), count(emp_no)
--  최소값        최대값         평균값         합계           개수
from employee;

-- 만약에  그룹함수 사용시 컬럼에 null이 있으면 계산 시 빠진다.
-- 예) 평균 낼 때 더할 때 빠지고 개수에서도 빠진다.





--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q13. employee 테이블에서 소속 부서 총 개수를 검색해서 출력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
count(distinct DEP_NO)
from EMPLOYEE;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q14. employee 테이블에서 담당직원이 있는 고객수를 검색해서 출력하면? ***
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
count(emp_no)
from CUSTOMER;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q15. 고객을 담당하고 있는 직원수?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
count(distinct emp_no)
from CUSTOMER;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q16. employee 테이블에서 직원번호, 직원명, 입사분기(~/4분기)를 검색해서 출력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
        EMP_NO,
       EMP_NAME,
       to_char(HIRE_DATE,'Q')||'/4분기' "입사분기"

from EMPLOYEE;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q17. employee 테이블에서 직원번호, 직원명, 근무년차를 검색해서 출력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
        EMP_NO,
       EMP_NAME,
        ceil((sysdate-HIRE_DATE)/365)||'년차'

from EMPLOYEE;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q18. employee 테이블에서 직원번호, 직원명, 담당직원번호 검색해서 출력하면? 단 직원번호가 없으면 '없음'으로 대체
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
------------------
-- null 처리 함수
------------------
-- nvl 함수
------------------
-- nvl( n1. n2) n1이 null이 아니면 n1 리턴 null이면 n2 리턴
------------------
select
    CUS_NO,
    CUS_NAME,
    nvl(emp_no||'','없음') -- 숫자와 문자를 비교할 수 없다 그래서 숫자에 공백하나를 슬쩍 끼워서 문자로 바꾼다.(자료형 통일)
from CUSTOMER;
select
    CUS_NO,
    CUS_NAME,
    nvl(to_char(emp_no),'없음') -- 이렇게 해도 위와 똑같다.
from CUSTOMER;
    --> emp_no 는 정수형이고 '없음'은 문자형이다 서로 다른 자료형의 데이터를 출력할 수 없다.

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q19. customer 테이블에서 고객번호, 고객명, 담당직원존재여부를 검색해서 출력하면?
--      즉 직원번호가 있으면 '있음' 없으면 '없음'으로 표시
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 1)decode 함수 활용
select
    CUS_NO,
    CUS_NAME,
           decode(emp_no,null,'없음','있음')

from CUSTOMER;
-- 2)case 함수 활용 (is null)
select
    CUS_NO,
    CUS_NAME,
         case
           when emp_no>=1 then '있음'
             else '없음'
         end "담당직원존재여부"
from CUSTOMER;
-- null 찾을땐 is null, null이 아닌 것 찾을땐 is not null
select
    CUS_NO,
    CUS_NAME,
         case
           when emp_no is null then '없음'
             else '있음'
         end "담당직원존재여부"
from CUSTOMER;
-- 3) nvl 함수 확용
select
    CUS_NO,
    CUS_NAME,
    nvl2(emp_no,'있음','없음')
from CUSTOMER;
-- nvl2( 컬럼명 ,  null이 아닐때 대체데이터 , null일때 대체데이터 )




--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q20. employee 테이블에서 직원번호, 직원명, 나이**, 연령대**를 검색해서 출력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
----------------------------------------
-- extract / decode / substr / floor
----------------------------------------
select
    EMP_NO "직원번호"
    ,EMP_NAME "직원명"
    ,extract(year from sysdate)
    -
    to_number(decode(substr(JUMIN_NUM,7,1),'1',19,'2',19,20)||substr(JUMIN_NUM,1,2))
    + 1 "나이"
    ,
    floor((extract(year from sysdate)-
            to_number(decode(substr(JUMIN_NUM,7,1),'1',19,'2',19,20)||substr(JUMIN_NUM,1,2))
           + 1)*0.1)
    ||'0대' "연령대"
from EMPLOYEE;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q21. employee 테이블에서 직급 순서대로 정렬하여 모든 컬럼을 보이면 ?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- sort 정렬 // 직급 순 // 사장 부장 과장 대리 사원 순
-- order by 정렬할거다 뭐로?(정렬대상)
-- asc(오름차순) (생략가능)
-- decode ( 작업대상 , 조건1, 실행1 ,조건2, 실행2)
-- case 작업대상 when 조건1 then 실행1 end

--방법 1
select * from EMPLOYEE order by decode(jikup,'사장',1,'부장',2,'과장',3,'대리',4,'사원',5) asc;
--방법 2
select * from EMPLOYEE order by
    case jikup
        when '사장' then 1
        when '부장' then 2
        when '과장' then 3
        when '대리' then 4
        when '주임' then 5
    end
    asc;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q22. employee 테이블에서 직급 순서대로 정렬하여 모든 컬럼을 보이면 ?
-- 단 직급이 같으면 나이가 많은 사람이 위로 가게하기***
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 정렬할때 여러번 중복 정렬하는 방법
--> 1. 직급순으로 정렬하고 그 안에서 2. 나이가 많은 순으로 정렬 (포함)
--> order by 컬럼1 , 컬럼2, 컬럼n   ( 컬럼1>컬럼2>컬럼n) 오른쪽으로 갈수록 포함된다.

select * from EMPLOYEE order by decode(jikup,'사장',1,'부장',2,'과장',3,'대리',4,'주임',5,6) asc
,extract(year from sysdate)
    -
    to_number(decode(substr(JUMIN_NUM,7,1),'1',19,'2',19,20)||substr(JUMIN_NUM,1,2))
    + 1 desc;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q23. employee 테이블에서 직급 순서대로 정렬하여 모든 컬럼을 보이면 ?
-- 단 직급이 같으면 먼저태어난 사람이 위로 가게하기***
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

select * from EMPLOYEE order by decode(jikup,'사장',1,'부장',2,'과장',3,'대리',4,'주임',5,6) asc
,
    decode(substr(JUMIN_NUM,7,1),'1',19,'2',19,20)||substr(JUMIN_NUM,1,6);


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q24. employee 테이블에서 수요일에 태어난 직원을 검색하라
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- to_date('원하는날짜문자열' , '원하는날짜패턴')
-- to_char( 특정날짜 , 'D' ) => 요일을 숫자로 변환한다.

-- 1)요일을 요일숫자로 비교
select*from EMPLOYEE where
to_char(
        to_date(decode(substr(JUMIN_NUM, 7, 1), '1', '19', '2', '19', '20') || substr(JUMIN_NUM, 1, 6), 'YYYYMMDD')
        ,'D'
    )=4;

-- 2)영어로 바꿔서 비교
select*from EMPLOYEE where
to_char(
        to_date(decode(substr(JUMIN_NUM, 7, 1), '1', '19', '2', '19', '20') || substr(JUMIN_NUM, 1, 6), 'YYYYMMDD')
        ,'DAY','NLS_DATE_LANGUAGE=English'
    )='WEDNESDAY';

-- 3)한글로 바꿔서 비교 ** 유저가 입력한 값 -> 수요일일 거다. JSP 에서 많이 쓰이는 쿼리.
select*from EMPLOYEE where
to_char(
        to_date(decode(substr(JUMIN_NUM, 7, 1), '1', '19', '2', '19', '20') || substr(JUMIN_NUM, 1, 6), 'YYYYMMDD')
        ,'DAY','NLS_DATE_LANGUAGE=Korean'
    )='수요일';

-- 4)소문자로 바꿔서 비교
select*from EMPLOYEE where
lower(to_char(
        to_date(decode(substr(JUMIN_NUM, 7, 1), '1', '19', '2', '19', '20') || substr(JUMIN_NUM, 1, 6), 'YYYYMMDD')
        ,'DAY','NLS_DATE_LANGUAGE=English'
    ))='wednesday';


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--  연  산  자  문  제
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q25. employee 테이블에서 직급이 과장인 직원을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select *from EMPLOYEE where JIKUP='과장';


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q26. employee 테이블에서 직급이 과장이 아닌 직원을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select *from EMPLOYEE where JIKUP !='과장';
select *from EMPLOYEE where JIKUP <> '과장';

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q27. employee 테이블에서 부서번호가 10번이고 직급이 과장인 직원을 검색하면?
--      = 10번 부서의 과장 검색해주세요.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select *from EMPLOYEE where JIKUP = '과장' and DEP_NO = 10;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q28. employee 테이블에서 직급이 과장 또는 부장인 직원을 검색
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

--방법1)
select *from EMPLOYEE where JIKUP = '과장' or  JIKUP = '부장';
--방법2)
-- in 이라는 연산자는 1. or 과 2. =이퀄의 의미를 동시에 갖고있다. (같은 칼럼을 여러번 반복해서 검색할때)
select * from EMPLOYEE where JIKUP in( '과장', '부장');
--방법3)
-- any 옆에는 =이 있다 or 만 갖고있다.
select * from EMPLOYEE where JIKUP = any( '과장', '부장');

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q29. employee 테이블에서 10번, 20번 부서 중에 직급이 과장인 직원을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

--------------------------------------------
-- ***** and 와 or 가 같이 나오면 and 를 먼저 연산한다 *****
--------------------------------------------

select * from EMPLOYEE where DEP_NO = 10 and JIKUP = '과장' or DEP_NO = 20 and JIKUP = '과장';
select * from EMPLOYEE where (DEP_NO=10 or DEP_NO=20)and JIKUP = '과장';
select * from EMPLOYEE where DEP_NO in(10,20)and JIKUP = '과장';

--------------------------------------------
--<주의>select * from employee where dep_no=10 or dep_no=20 and jikup = '과장';은 답이 안된다.
-- 이유 : 10번 부서 다 나오고 20번 부서의 과장이 나온다.
-- 둥근괄호()를 아낌없이 써라!
--------------------------------------------


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q30. customer 테이블에서 담당직원이 없는 고객을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

select * from customer where emp_no is null;
-- <주의> null 값을 찾을 때는 =를 쓰지말고 is 를 써라


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q31. customer 테이블에서 담당직원이 있는 고객을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

select * from customer where emp_no is not null;
-- <주의> null 값이 아닌 놈을 찾을 때는 !=를 쓰지말고 is not 를 써라



--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q32. customer 테이블에서 담당직원 번호가 9번이 아닌 고객을 검색하면?
-- (**입사시험문제 단한명도 못맞힘.)아주 중요/조심해야한다.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm


select * from customer where emp_no != 9; --> 정답 아니다.
select * from customer where emp_no != 9 or emp_no is null; --> 이게 정답이다.

---------------------------------------------------------------
--*********************** 중 요 ***************************
---------------------------------------------------------------
-- null 이 있을 수 있다..............그래서 null도 봐줘야 한다...........
---------------------------------------------------------------
-- !=9 는 9가 아닌 데이터만 찾는다. null은 데이터가 아니라 찾지 않는다.
---------------------------------------------------------------
-- ???가 아닌 놈을 찾을땐 데이터만 찾는다. ???가 널이 아닌 데이터라면. ???가아닌 데이터만 찾는다.
--그래서 null도 따로 찾아 줘야 한다.
---------------------------------------------------------------
---------------------------------------------------------------
--<주의> emp_no!=9에서 null은 9가 아닌 놈으로 여기지 않는다.
--      null 은 데이터 취급하지 않는다. 즉 9가 아닌 데이터를 찾는 것이다.
--      즉 null 은 is null 또는 is not null 연산자에 의해서만 검색된다.
---------------------------------------------------------------


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q33. employee 테이블에서 연봉이 4000만원 이상인 직원은?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select *
from EMPLOYEE where SALARY>=4000;



--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q34. employee 테이블에서 연봉이 3000 ~ 4000만원 사이인 직원은?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

---------------------------------------------------------------
-- between
--칼럼명 + between 최소값 and 최대값 ( 최소값 이상 최대값 이하) (최대값 미만 아니다)
---------------------------------------------------------------

select * from EMPLOYEE where SALARY>=3000 and SALARY<4000;
select * from EMPLOYEE where SALARY between 3000 and 4000 and SALARY!=4000;
select * from EMPLOYEE where SALARY between 3000 and 4000 and SALARY<>4000;




--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q35. employee 테이블에서 연봉을 5% 인상할 경우에 3000 이상인 직원을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 인상하라는게 아니라 인상을 가정했을 경우이다.

select  * from EMPLOYEE where SALARY*1.05>=3000;



--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q36. employee 테이블에서 입사일이 '1995-1-1' 이상인 직원을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 날짜는 날짜끼리 비교 연산이 가능하다 (날짜>날짜) 가능

select  * from  EMPLOYEE where HIRE_DATE > to_date('1995-1-1','YYYY-MM-DD');

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q37. employee 테이블에서 입사일이 1990~1999년 사이인 직원 검색?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

select*from EMPLOYEE
where HIRE_DATE >= to_date('1990-1-1','YYYY-MM-DD')
  and HIRE_DATE < to_date('2000-1-1','YYYY-MM-DD');

select * from EMPLOYEE
where extract(year from HIRE_DATE) >= 1990
  and extract(year from HIRE_DATE) <= 1999;

select * from EMPLOYEE
    where extract(year from HIRE_DATE) between 1990 and 1999;

select * from EMPLOYEE
    where substr(to_char(hire_date,'YYYY'),1,3)='199';

select * from EMPLOYEE
    where to_char(HIRE_DATE,'YYYY') like '199%';
-- %의 의미는 무엇이 와도 좋아. 길이 제한 없어.
-- like 연산자의 형태와 기능
-- where 컬럼명 like '문자패턴' => 컬럼명 안의 데이터가 문자패턴에 맞으면 그 행을 보이라.


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q38. employee 테이블에서 부서번호가 10번 또는 30번인 직원 중에 연봉이 3000미만이고
--      입사일이 '1996-01-01' 이전 인 직원은 ?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select * from EMPLOYEE
    where
      (DEP_NO = 10 or DEP_NO = 30)
      and SALARY < 3000
      and HIRE_DATE<to_date('1996-01-01','YYYY-MM-DD');

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q39. employee 테이블에서 부서번호가 10번인 직원 중에 연봉이 2000미만
--      또는 부서번호 20번인 직원중에 연봉이 3500 이상인 직원은?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select * from EMPLOYEE
    where (DEP_NO = 10 and SALARY < 2000) or (DEP_NO = 20 and SALARY >= 3500);


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q40. employee 테이블에서 성이 김씨 직원은?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select * from EMPLOYEE
    where substr(EMP_NAME,1,1)='김';

select * from EMPLOYEE
    where EMP_NAME like '김%';


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q41. employee 테이블에서 직원 이름이 '라'로 끝나는 직원 검색
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

select * from EMPLOYEE
    where substr(EMP_NAME,length(EMP_NAME),1)='라';

select * from EMPLOYEE
    where EMP_NAME like '%라';


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q42. employee 테이블에서 성이 김씨이고 3글자인 직원 검색
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

select * from EMPLOYEE
    where EMP_NAME like '김%' and length(EMP_NAME)=3;
select * from EMPLOYEE
    where substr(EMP_NAME,1,1) ='김' and length(EMP_NAME)=3;
select * from EMPLOYEE
    where EMP_NAME like '김__';
-- like 연산자 오른쪽에 나오는 '_' 의 의미 => 무엇이 나와도 좋은데 글자 1개야! 라는 뜻


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q43. employee 테이블에서 이름에 김이 들어간 직원을 검색하면? 즉 이름에 김을 포함하는 직원은?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select * from EMPLOYEE
    where EMP_NAME like '%김%';
-- 칼럼명 like '%x%' => 컬럼에 'x' 를 포함하는 행은 나와라

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q44. employee 테이블에서 이름이 2자인 직원을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select * from EMPLOYEE where length(emp_name)=2;
select * from EMPLOYEE where emp_name like '__';
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q45. employee 테이블에서 이름이 중간에만 김이 들어간 직원을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-------------------------
-- like 반대 => not like
-------------------------
    select * from EMPLOYEE where EMP_NAME
    like '%김%' and substr(EMP_NAME,1,1)='김' and substr(EMP_NAME,length(EMP_NAME),1)='김';

    select * from EMPLOYEE where EMP_NAME
    like '%김%' and EMP_NAME not like '%%김' and EMP_NAME not like '김%%';

    select * from EMPLOYEE where regexp_like(EMP_NAME,'^[^김][김]+[^김]$');


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q46. employee 테이블에서 여자 직원을 검색하라
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select *from EMPLOYEE
    where substr(JUMIN_NUM,7,1)='2' or substr(JUMIN_NUM,7,1)='4';

    select * from EMPLOYEE
    where substr(JUMIN_NUM,7,1) in('2','4');

    select * from EMPLOYEE
    where JUMIN_NUM like '______2%' or JUMIN_NUM like '______4%';


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q47. 아래 select 문은 무슨 요구사항을 반영한 것인가?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select * from EMPLOYEE
    where JUMIN_NUM like'______1%'or JUMIN_NUM like '______2%';
    -- 즉 1900년대 생을 검색해라


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q48.employee 테이블에서 1960년대, 1970년대 출생자 중 남자만 검색하라.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

    select * from EMPLOYEE
    where (JUMIN_NUM like '6%' or JUMIN_NUM like'7%') and
          (JUMIN_NUM like '______1%' or JUMIN_NUM like '______3%');

    select * from EMPLOYEE
    where (substr(JUMIN_NUM,1,1)='6' or substr(JUMIN_NUM,1,1)='7') and
          (substr(JUMIN_NUM,7,1)='1' or substr(JUMIN_NUM,7,1)='3');

    select * from EMPLOYEE
    where (substr(JUMIN_NUM,1,1) in('6','7') )and
          (substr(JUMIN_NUM,7,1)='1' or substr(JUMIN_NUM,7,1)='3');

    select * from EMPLOYEE
    where (JUMIN_NUM like'6_____1%' or  JUMIN_NUM like'7_____1%');


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q49.(함수문제) 직원번호, 직원명, 주민번호, 다가올생일(xxx-xx-xx(월)), 생일까지 남은 일수를 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select EMP_NO, EMP_NAME, JUMIN_NUM,
--     sysdate 2020-12-29 2020-12-31 2020-12-30
--     올해 내생일에서 오늘 날짜를 빼서 양수가 나오면 올해 내생일
--     올해 내생일에서 오늘 날짜를 빼서 음수가 나오면 내년 내생일
case when
    to_date(
        to_char(sysdate,'YYYY')||substr(JUMIN_NUM,3,4),'YYYYMMDD'
    )
    - sysdate
    > 0
    then to_char(
            to_date(
                to_char(sysdate,'YYYY')||substr(JUMIN_NUM,3,4)
                ,'YYYYMMDD'
            )
        ,'YYYY-MM-DD(dy)','NLS_DATE_LANGUAGE=Korean'
        )

    else to_char(
            to_date(
                (to_number(to_char(sysdate,'YYYY'))+1)
                ||substr(JUMIN_NUM,3,4)
                ,'YYYYMMDD'
            )
        ,'YYYY-MM-DD(dy)','NLS_DATE_LANGUAGE=Korean'
        )
    end"다가올 생일 기념일"


,case
    when to_date(
        to_char(sysdate,'YYYY')||substr(JUMIN_NUM,3,4),'YYYYMMDD'
    )
    - sysdate
    > 0

    then
    ceil(
        to_date(
                to_char(sysdate, 'YYYY') || substr(JUMIN_NUM, 3, 4)
            , 'YYYYMMDD'
            )
        - sysdate
        )
else ceil(
        to_date(
                    (to_number(to_char(sysdate,'YYYY'))+1)
                    ||substr(JUMIN_NUM,3,4)
                    ,'YYYYMMDD'
                )
        - sysdate
      )

end "생일 D-day"

from EMPLOYEE
order by 4 asc;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q49. 아래 처럼 테이블을 만들고 데이터를 입력한 상태에서
--      제품 총 개수를 내림차순으로 제일 많은 것부터 정렬하여 보이면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

    create table product (
        p_no number(3)
        ,p_name varchar2(20)    not null unique
        , tot_cnt varchar2(20)  not null
    );

    insert into product values(1,'컴퓨터1','20');
    insert into product values(2,'컴퓨터2','2');
    insert into product values(3,'컴퓨터3','4');
    insert into product values(4,'컴퓨터4','2');
    insert into product values(5,'컴퓨터5','16');
    insert into product values(6,'컴퓨터6','60');
    insert into product values(7,'컴퓨터7','30');
    insert into product values(8,'컴퓨터8','27');
    insert into product values(9,'컴퓨터9','25');
    insert into product values(10,'컴퓨터10','22');
    insert into product values(11,'컴퓨터11','34');
    insert into product values(12,'컴퓨터12','50');
    insert into product values(13,'컴퓨터13','8');
    insert into product values(14,'컴퓨터14','9');
    insert into product values(15,'컴퓨터15','10');

select * from PRODUCT order by to_number(tot_cnt) desc;
---------------------------------------------------------
-- 1. 길이가 긴걸 먼저 위로 올린다. 2. 아스키코드값 순서~
select * from PRODUCT order by length(tot_cnt) desc, tot_cnt desc;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 2. join 문제 *******
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- oracle 4대천왕 [1.함수 2.join 3.subquery 4.group by] => 모두 select 안에 나온다.
-- 두개이상 테이블에서 칼럼을 복사해서 행으로 붙여 보여주는것을 join 조인이라고 한다

-- 두개이상 테이블에서 칼럼을 복사해서 위아래로 붙여 보여주는것을 union 유니온이라고 한다
select EMP_NAME"이름", JUMIN_NUM "주민번호" ,'직원' "구별" from EMPLOYEE
    union
select CUS_NAME, JUMIN_NUM,'고객' from CUSTOMER;



--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q50. 직원번호, 직원명, 직급, 소속부서명"을 출력하면? (employee/dept)
--      단 소속부서가 있는 놈만 나와라.(inner join)
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 서로 다른 칼럼을 좌우로 붙인다.
--join은 where 절을 조심해야한다.

----------------------------
-- 정답 1) 오라클 방식의 조인
----------------------------
    select
          EMPLOYEE.EMP_NO   "직원번호"
         ,EMPLOYEE.EMP_NAME "직원명"
         ,EMPLOYEE.JIKUP    "직급"
         ,DEPT.dep_name     "소속부서명"
    from EMPLOYEE,DEPT
    where EMPLOYEE.DEP_NO=DEPT.DEP_NO;
-- where : 칼럼이 붙을 조건이 나오면 된다.
----------------------------
-- 정답 2) 오라클 방식의 조인
----------------------------
    select
          e.EMP_NO      "직원번호"
         ,e.EMP_NAME    "직원명"
         ,e.JIKUP       "직급"
         ,d.dep_name    "소속부서명"
    from EMPLOYEE e , DEPT d  -- 테이블이름에 컬럼 별칭을 주면(변수처럼 사용가능.)
    where e.DEP_NO = d.DEP_NO; --칼럼이 붙을 조건이 나오면 된다.
----------------------------
-- 정답 3) ANSI 방식의 조인
----------------------------
    select
          e.EMP_NO      "직원번호"
         ,e.EMP_NAME    "직원명"
         ,e.JIKUP       "직급"
         ,d.dep_name    "소속부서명"

    from EMPLOYEE e inner join DEPT d  -- 테이블이름에 컬럼 별칭을 주면(변수처럼 사용가능.)

    on e.DEP_NO = d.DEP_NO; --칼럼
    --inner join 조건에 맞는 놈만 나온다.

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q51. 고객명, 고객전화번호, 담당직원명, 담당직원직급 을 출력하면? <조건> 담당직원이 있는 고객만 출력
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm


----------------------------
-- 정답 1) 오라클 방식의 Join
----------------------------
select
    c.CUS_NAME  "고객명"
    ,c.TEL_NUM  "고객전화번호"
    ,e.EMP_NAME "담당직원명"
    ,e.JIKUP    "담당직원직급"
from CUSTOMER c , EMPLOYEE e
where c.EMP_NO = e.EMP_NO;
----------------------------
-- 정답 2) ANSI 방식의 Join
----------------------------
select
    CUSTOMER.CUS_NAME   "고객명"
    ,CUSTOMER.TEL_NUM   "고객전화번호"
    ,EMPLOYEE.EMP_NAME  "담당직원명"
    ,EMPLOYEE.JIKUP     "담당직원직급"
from CUSTOMER inner join EMPLOYEE
on CUSTOMER.EMP_NO = EMPLOYEE.EMP_NO;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q52. 고객명, 고객전화번호, 담당직원명, 담당직원직급 출력하면?
--      <조건> 10번부서의 담당직원이 있는 고객만 출력
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

----------------------------
-- 정답 1) 오라클 방식의 Join
----------------------------
select
c.CUS_NAME
,c.TEL_NUM
,e.EMP_NAME
,e.JIKUP
from CUSTOMER c, EMPLOYEE e
where c.EMP_NO=e.EMP_NO and e.DEP_NO=10;
-- 오라클 조인에서 where 절에 join 조건과 행을 골라내는 조건이 같이 나온다.

----------------------------
-- 정답 2) ANSI 방식의 Join
----------------------------
select
c.CUS_NAME
,c.TEL_NUM
,e.EMP_NAME
,e.JIKUP

from CUSTOMER c inner join EMPLOYEE e
on c.emp_no = e.EMP_NO
where e.DEP_NO=10;
-- [ansi 방식의 join 에서는] 조인 조건은 on 뒤에 나온다.
-- [ansi 방식의 join 에서는] 행을 골라 내는 조건은 where 뒤에 나온다.

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q53. 직원번호, 직원명, 직원직급, 직원소속부서명, 담당고객명, 고객전화번호 를 출력하면?
--      <조건> 조건에 맞는 직원만 나오기, 직원이름 오름차순 정렬 (삼중inner조인)
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
----------------------------
-- 정답 1) 오라클 방식의 Join
----------------------------
select
 e.emp_no         "직원부서명"
,e.EMP_NAME       "직원명"
,e.JIKUP          "직원직급"
,d.DEP_NAME       "직원소속부서명"
,c.CUS_NAME       "담당고객명"
,c.TEL_NUM        "고객전화번호"

from EMPLOYEE e , CUSTOMER c, DEPT d
where c.EMP_NO= e.EMP_NO and e.DEP_NO = d.DEP_NO
order by e.EMP_NAME asc;

----------------------------
-- 정답 2) ANSI 방식의 Join
----------------------------

select
 e.emp_no         "직원부서명"
,e.EMP_NAME       "직원명"
,e.JIKUP          "직원직급"
,d.DEP_NAME       "직원소속부서명"
,c.CUS_NAME       "담당고객명"
,c.TEL_NUM        "고객전화번호"

from (EMPLOYEE e inner join DEPT d on e.DEP_NO = d.DEP_NO)
        inner join CUSTOMER c on c.EMP_NO= e.EMP_NO

order by e.EMP_NAME asc;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q54. 직원번호e, 직원명e, 직원직급e, 연봉등급e 을 출력하면?*******
-- <inner join> <non - equi 조인>
-- <2중조인>
-- order by 연봉등급 오름차순, 직급높은순서 오름차순, 나이많은순서 내림 유지 요망.(태어난순서 오름 유지 요망)
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

select
     e.emp_no         "직원번호"
    ,e.EMP_NAME       "직원명"
    ,e.JIKUP          "직원직급"
    ,s.SAL_GRADE_NO   "연봉등급"

from EMPLOYEE e , SALARY_GRADE s
where
    e.SALARY >= s.MIN_SALARY and e.SALARY <= s.MAX_SALARY

order by s.SAL_GRADE_NO asc ,

         decode(e.JIKUP,'사장',1,'부장',2,'과장',3,'대리',4,'사원',5,6) asc ,
         case
             when substr(e.JUMIN_NUM,7,1) in('1','2') then '19'
             else '20'
        end || substr(e.JUMIN_NUM,1,6) asc;
--   asc      /     desc
-- 낮은거 먼저       많은거 먼저
----------------------------------------
-- 조건의 90% inner join -- outer join --
----------------------------------------
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q55. 부하직원명, 부하직원직급, 직속상관명, 직속상관직급을 출력하면 ?
--      <조건> 상관이 있는 직원만 포함
--      self join : 하나의 테이블을 두개로 보는 것
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--  FK / PK
--  부하직원명, 부하직원직급 - employee / 직속상관명, 직속상관직급 - employee

-- oracle 방식
select

    e1.EMP_NAME,
    e1.JIKUP,
    e2.EMP_NAME,
    e2.JIKUP

from EMPLOYEE e1 , EMPLOYEE e2
where e1.MGR_EMP_NO=e2.EMP_NO;

-- ansi 방식
select
    e1.EMP_NAME,
    e1.JIKUP,
    e2.EMP_NAME,
    e2.JIKUP
from EMPLOYEE e1 inner join EMPLOYEE e2 on e1.MGR_EMP_NO=e2.EMP_NO;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.56 상관직원명, 상관직원직급, 직속부하명, 직속부하직급을 출력하면?
-- <조건> 직속부하가 있는 직원만 포함 <self join>
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

select
    e1.EMP_NAME "상관직원명"
    , e1.JIKUP "상관직원직급"
    ,e2.EMP_NAME "직속부하명"
    ,e2.JIKUP   "직속부하직급"

from EMPLOYEE e1 , EMPLOYEE e2
where e1.EMP_NO = e2.MGR_EMP_NO;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.57 직원번호, 직원명, 소속부서명, 직원직급, 연봉등급, 직속상관이름명, 상관직급, 고객명을 출력하면 ?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
    e1.EMP_NO
    ,e1.EMP_NAME
    , d.DEP_NAME
    , e1.JIKUP
    , s.SAL_GRADE_NO
    , e2.EMP_NAME
    , e2.JIKUP
    , c.CUS_NAME
from EMPLOYEE e1,  DEPT d , SALARY_GRADE s, EMPLOYEE e2 , CUSTOMER c
where e1.DEP_NO = d.DEP_NO  and
      e1.SALARY >= s.MIN_SALARY and e1.SALARY <=s.MAX_SALARY
     and e1.EMP_NO=c.EMP_NO
    and e1.MGR_EMP_NO = e2.EMP_NO
order by 1 asc;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.58 고객명, 고객전화번호 담당직원명, 담당직원직급을 출력하면?
--  1-<조건> 담당직원이 없는 고객은 제외
--  2-<조건> 담당직원이 없는 고객도 포함** (+) 용법의 의미(오라클 outer join)
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

--------------------------
-- oracle 방식의 outer join
--------------------------
select
       c.CUS_NAME,
       c.TEL_NUM,
       e.EMP_NAME,
       e.JIKUP
from CUSTOMER c , EMPLOYEE e
where c.EMP_NO = e.EMP_NO(+);
--------------------------
-- where c.EMP_NO = e.EMP_NO(+); 의 의미
--------------------------
-- (+)가 붙은 컬럼의 반대편 컬럼의 소속테이블 행은 모두 나오고

-- (+)가 붙은 e.emp_no 컬럼의 소속 테이블 행은
-- 조건에 맞는게 없으면 null이라도 달고 나오라는 뜻.


--------------------------
-- ansi 방식의 outer join - (1)
--------------------------
select
       c.CUS_NAME,
       c.TEL_NUM,
       e.EMP_NAME,
       e.JIKUP
from CUSTOMER c left outer join EMPLOYEE e
on c.EMP_NO = e.EMP_NO;

--------------------------
-- ansi 방식의 outer join - (2)
--------------------------
select
       c.CUS_NAME,
       c.TEL_NUM,
       e.EMP_NAME,
       e.JIKUP
from EMPLOYEE e right outer join CUSTOMER c
on c.EMP_NO = e.EMP_NO;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.59 고객번호, 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면?( 10번부서만 )
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 고객은 다나오고 직원은 조건에 맞으면 나오고 . 10번부서 애들만 나와라
select
c.cus_no,
c.CUS_NAME,
c.TEL_NUM,
e.EMP_NAME,
e.JIKUP,
e.DEP_NO
from CUSTOMER c , EMPLOYEE e
where
c.EMP_NO = e.EMP_NO(+) and e.DEP_NO(+)=10;
---------------------
-- outer 조인에서 [조인조건]에(+)가 붙은 컬럼의 테이블의
-- 모든 컬럼뒤에도 (+)가 붙어야 outer 조인 효과가 나타난다.
-----------------------
--<문> 만약 e.dep_no(+)=10을 e.dep=10으로 수정하면?
---------------------
--담당직원이 10번부서인 고객만 포함된다
--outer 조인 효과를 보려면 [조인조건]에 (+)가 붙은 테이블의 모든 컬럼에도 (+)가 붙어야한다.
--<참고> 오라클조인에서 where 절에ㅓ 일반 조건을 수행하고 조인조건을 수행한다.
---------------------
-- ansi 방식
---------------------
select
c.cus_no,
c.CUS_NAME,
c.TEL_NUM,
e.EMP_NAME,
e.JIKUP,
e.DEP_NO
from CUSTOMER c left outer join EMPLOYEE e
on c.EMP_NO = e.EMP_NO and e.DEP_NO=10;
---------------------
--ansi 방식에서 outer 조인 시 where 가 나오면 행이 골라지므로 where 절의 조건도 on절에 나온다.
--------------------------

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.60 고객번호, 고객명, 고객전화번호, 담당직원명, 담당직원직급, 담당직원연봉등급을 출력하면?
-- <조건> 담당직원이 없는 고객도 포함
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-----------------------
-- oracle 방식
-----------------------
    select
        c.cus_no,
        c.CUS_NAME,
        c.TEL_NUM,
        e.EMP_NAME,
        e.JIKUP,
        s.SAL_GRADE_NO
    from CUSTOMER c , EMPLOYEE e, SALARY_GRADE s
    where
        c.EMP_NO = e.EMP_NO(+) and e.SALARY>=s.MIN_SALARY(+) and e.SALARY<=s.MAX_SALARY(+);
------------------------------------------------------
-- employee 테이블은 customer 에 딸려 나오고, salary_grade는 employee 에 딸려나오는것이므로
-- 딸려나오는 쪽에 (+)가 붙으면 된다.
-- 다음처럼 (+)가 연산자 양쪽에 나올 수 는 없다
--  e.SALARY(+)>=s.MIN_SALARY(+) and e.SALARY(+)<=s.MAX_SALARY(+)  <-- X
------------------------------------------------------
---------------------------
--ansi 방식
---------------------------
select
        c.cus_no,
        c.CUS_NAME,
        c.TEL_NUM,
        e.EMP_NAME,
        e.JIKUP,
        s.SAL_GRADE_NO
from
    (CUSTOMER c left outer join EMPLOYEE e on c.EMP_NO=e.EMP_NO)
    left outer join SALARY_GRADE s on s.MIN_SALARY<= e.SALARY and s.MAX_SALARY>=e.SALARY;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.61 고객번호, 고객명, 고객주민번호 출력하라
-- 조건 단 연봉이 3000이상인 담당직원이 담당한 고객이어야 .
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

select
    c.CUS_NO,
    c.CUS_NAME,
    c.JUMIN_NUM
from CUSTOMER c , EMPLOYEE e
where
       e.EMP_NO = c.EMP_NO and e.SALARY >= 3000;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.62 고객번호, 고객명, 고객전화번호 출력하라
-- 조건 단 40살 이상인 담당직원이 담당한 고객이어야한다.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
    c.CUS_NO,
    c.CUS_NAME,
    c.JUMIN_NUM
from CUSTOMER c , EMPLOYEE e
where
       e.EMP_NO = c.EMP_NO and
        extract(year from sysdate)-
        extract(year from to_date(
                decode(substr(e.JUMIN_NUM,7,1),'1','19','2','19','3','20','4','20')
                ||substr(e.JUMIN_NUM,1,6),'YYYYMMDD')
                )
        + 1 >=40;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.63 고객번호, 고객명, 담당직원번호, 담당직원명, 담당직원소속부서명, 담당직원연봉등급,
-- 담당직원직속상관명, 담당직원직속상관직급, 직속상관연봉등급 을 출력하라
-- 단 고객은 다 나와야하고 null은 없음으로 표시
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
---------------------
--오라클방식 outer join
---------------------
select
     c.CUS_NO                            "고객번호"
    ,c.CUS_NAME                          "고객명"
    ,nvl(to_char(e1.EMP_NO),'없음')       "담당직원번호"
    ,nvl(e1.EMP_NAME,'없음')              "담당직원명"
    ,nvl(d.DEP_NAME,'없음')               "담당직원소속부서명"
    ,nvl(to_char(s1.SAL_GRADE_NO),'없음') "담당직원연봉등급"
    ,nvl(e2.EMP_NAME,'없음')              "담당직원직속상관명"
    ,nvl(e2.JIKUP,'없음')                 "담당직원직속상관직급"
    ,nvl(to_char(s2.SAL_GRADE_NO),'없음') "직속상관연봉등급"

from EMPLOYEE e1 , CUSTOMER c , DEPT d, SALARY_GRADE s1, EMPLOYEE e2, SALARY_GRADE s2
where
      c.EMP_NO = e1.EMP_NO(+)
    and d.DEP_NO(+) = e1.DEP_NO
  and e1.MGR_EMP_NO = e2.EMP_NO(+)
and e1.SALARY>=s1.MIN_SALARY(+) and e1.SALARY<=s1.MAX_SALARY(+)
and e2.SALARY>=s2.MIN_SALARY(+) and e2.SALARY<=s2.MAX_SALARY(+)
order by c.CUS_NO asc;

---------------------
--ansi 방식 outer join
---------------------
select
     c.CUS_NO                            "고객번호"
    ,c.CUS_NAME                          "고객명"
    ,nvl(to_char(e1.EMP_NO),'없음')       "담당직원번호"
    ,nvl(e1.EMP_NAME,'없음')              "담당직원명"
    ,nvl(d.DEP_NAME,'없음')               "담당직원소속부서명"
    ,nvl(to_char(s1.SAL_GRADE_NO),'없음') "담당직원연봉등급"
    ,nvl(e2.EMP_NAME,'없음')              "담당직원직속상관명"
    ,nvl(e2.JIKUP,'없음')                 "담당직원직속상관직급"
    ,nvl(to_char(s2.SAL_GRADE_NO),'없음') "직속상관연봉등급"

from CUSTOMER c
    left outer join EMPLOYEE e1 on c.EMP_NO = e1.EMP_NO
    left outer join dept d on e1.DEP_NO = d.DEP_NO
    left outer join SALARY_GRADE s1 on e1.SALARY between s1.MIN_SALARY and s1.MAX_SALARY
    left outer join EMPLOYEE e2 on e1.MGR_EMP_NO = e2.EMP_NO
    left outer join SALARY_GRADE s2 on e2.SALARY between s2.MIN_SALARY and s2.MAX_SALARY
order by c.CUS_NO asc;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 3. subquery 문제 *****
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
------------------------------------
-- subquery(서브쿼리?)
------------------------------------
    -- select, insert, update, delete 구문안에 들어있는 또다른 select 문을 말한다.
------------------------------------
-- subquery 사용시 주의점
------------------------------------
    -- select, update, delete 안의 서브쿼리는 꼭 ()로 묶는다.
    -- insert 안의 서브쿼리는 ()로 묶지 않는다.
    -- 경우에 따라 join 대신 subquery를 써도 같은 결과를 낼 수 있다.
        -- (이때 join 보다 subquery 의 부하가 더 많이 걸린다.)
------------------------------------
-- subquery 종류
------------------------------------
    -- 비 상관 쿼리       => [서브쿼리]와 [외부쿼리]가 연관성이 없다. [서브 쿼리] 실행 후의 결과값을 가지고 메인쿼리 실행된다.
    -- 상관 쿼리(**어렵다) => [서브쿼리]와 [외부쿼리]가 연관성이 있다. [서브 쿼리]와 [외부 쿼리]가 서로 통신을 하면서 실행된다.

------------------------------------
-- Q.89 최고/최저 연봉을 받는 직원을 검색하라.
------------------------------------
select * from EMPLOYEE where SALARY = (select max(SALARY) from EMPLOYEE); -- 비상관쿼리다.
select * from EMPLOYEE where SALARY = (select min(SALARY) from EMPLOYEE); -- 비상관쿼리다.
    ------------------------------------
    --아래처럼 하면 안된다.
    ------------------------------------
    -- select * from employee where salary = max(salary);
    ------------------------------------
    -- 그룹함수(min max sum avg count)는 select 절에만 나와야한다.
    -- max(salary) 코딩은 select 절에서만 나와야한다.
    -- * 즉 max 함수가 끌어안아서 나온 결과가 어떤 테이블 소속인지 모르면 안된다. *
    -- select 절 안에 나오면 from 절 뒤의 테이블 소속이라는 걸 알 수 있으니까 가능하다.
    -- where 절 안에 나오면 누구 컬럼인지 모르니까 안된다.
    -- 그룹 함수의 특징이다. 그룹함수(min, sum, avg, count)도 동일하다.

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.90 평균 연봉 이상을 받는 직원을 검색하라.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select * from EMPLOYEE where SALARY > (select avg(SALARY) from EMPLOYEE);

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.91 20번 부서에서 최고 연봉자 직원을 검색하라.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select * from EMPLOYEE where DEP_NO = 20 and SALARY = (select max(SALARY) from EMPLOYEE where DEP_NO=20);
    ----------------------
    -- 아래처럼 코딩하면 안된다.
    ----------------------
    select * from EMPLOYEE where SALARY = (select max(SALARY) from EMPLOYEE where DEP_NO=20);
    -- 모든 부서 안에 20번부서의 최대 연봉과 같은 사람 다나와가 된다. 그래서 틀린 답.

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.92 [직원명], [직급], [연봉], [전체연봉에서 차지하는 비율]을 검색하라.
--      [전체연봉에서 차지하는 비율]은 소수점 버림 %로 표현하라.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- floor : 소수점 버리는 함수
select
    EMP_NAME      "직원명"
    ,JIKUP      "직급"
    ,SALARY     "연봉"
    ,floor(SALARY/(select sum(SALARY) from EMPLOYEE)*100)||'%' "연봉비율"
from EMPLOYEE;


-- trunc 쓰게 되면 trunc(특정숫자, 0)
select
    EMP_NAME      "직원명"
    ,JIKUP      "직급"
    ,SALARY     "연봉"
    ,trunc(SALARY/(select sum(SALARY) from EMPLOYEE)*100,0)||'%' "연봉비율"
from EMPLOYEE;

--  자리수 세자리 확보하고 출력 .(앞에 빌경우 0 으로 채운다.) -to_char(특정숫자,'999') -- <주의> 이건 반올림된다.
select
    EMP_NAME      "직원명"
    ,JIKUP      "직급"
    ,SALARY     "연봉"
    ,to_char(SALARY/(select sum(SALARY) from EMPLOYEE)*100,'999')||'%' "연봉비율"
from EMPLOYEE;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.93 10번부서 직원들이 관리하는 [고객번호], [고객명], [직원번호]를 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
----------------------------
-- join 사용 답
----------------------------
select
       c.CUS_NO,
       c.CUS_NAME,
       e.EMP_NO
from CUSTOMER c , EMPLOYEE e
where c.EMP_NO = e.EMP_NO and e.DEP_NO =10;
----------------------------
-- subquery 사용 답
----------------------------
-- 답 1
----------------------------
-- in ( , , , ) 로 나열되는데 여러개 중 데이터가 하나이지만 in을 안쓰면 안에 데이터가 여러개이기 때문에 에러가 난다.
select
       CUS_NO,
       CUS_NAME,
       EMP_NO
from CUSTOMER
where EMP_NO in (select EMP_NO from EMPLOYEE where DEP_NO=10);
----------------------------
-- 답 2
----------------------------
select
       CUS_NO,
       CUS_NAME,
       EMP_NO
from CUSTOMER
where EMP_NO = any (select EMP_NO from EMPLOYEE where DEP_NO=10);
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.94 직원명이 한국남과 직급이 동일한 직원을 검색하라
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select * from EMPLOYEE where JIKUP=(select JIKUP from EMPLOYEE where EMP_NAME='한국남');

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.95 직원명이 무궁화와 직급이 동일한 직원을 검색하라
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- =이퀄 뒤에 나오는 데이터는 하나여야하는데 무궁화는 두명일 경우에 .. 에러가 난다.
-- =이퀄을 빼는 in을 쓰면 된다.
select * from EMPLOYEE where JIKUP in (select JIKUP from EMPLOYEE where EMP_NAME='무궁화');


-------------------------------
-- 상관 쿼리 문제 *
-------------------------------
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.96 담당 고객이 2명 이상인 [직원번호], [직원명], [직급]을 검색하면?(***)
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 테이블이 하나밖에 없는데 알리아스(별칭 e.~)를 쓴다면 상관쿼리라는 의미.
-- 바깥족 테이블에 있는 쿼리를 안쪽에 쓰고있다면 상관쿼리다.
select
     e.EMP_NO
    ,e.EMP_NAME
    ,e.JIKUP
from EMPLOYEE e
where (select count(*) from CUSTOMER c where e.EMP_NO = c.EMP_NO)>=2;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.97 최고 연봉 직원의 [직원번호], [직원명], [부서명], [연봉]을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
----------------------------
--join 사용한 답
----------------------------
    select
        e.EMP_NO
        ,e.EMP_NAME
        ,d.DEP_NAME
        ,e.SALARY
    from EMPLOYEE e , DEPT d
    where d.DEP_NO = e.DEP_NO and e.SALARY = (select max(SALARY) from EMPLOYEE) ;
----------------------------
--join 사용하지 않고 상관쿼리로 답
----------------------------
    select
        e.EMP_NO
        ,e.EMP_NAME
        ,(select dep_name from DEPT d where e.DEP_NO=d.DEP_NO)
        ,e.SALARY

    from EMPLOYEE e
    where e.SALARY = (select max(salary) from employee);


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.98 평균 연봉이상이고 최대 연봉 미만의 [직원번호], [직원명], [부서명], [연봉]을 출력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
    e.EMP_NO , e.EMP_NAME , d.DEP_NAME , e.SALARY
from EMPLOYEE e , DEPT d
    where  SALARY >= (select avg(salary) from EMPLOYEE) and SALARY<(select max(SALARY) from EMPLOYEE);

select
    e.EMP_NO
    ,e.EMP_NAME
    ,(select DEP_NAME from dept d where d.DEP_NO = e.DEP_NO)
    ,e.SALARY
from EMPLOYEE e
where e.SALARY >= (select avg(SALARY) from EMPLOYEE)
  and e.SALARY < (select max(SALARY) from EMPLOYEE);

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.99 연봉 상위 5명의 직원을 검색하면? (***)(rownum/inline view)
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
------------------------------------------------------------
-- rownum : 존재하지않는 컬럼이 새로 생성되어 일련번호를 만들어준다.
--          모든 셀릭트문에 슬쩍 넣어주는 (oracle)서비스용 컬럼이다.
------------------------------------------------------------
-- order by 하기전에 rownum 이 들어가기 때문에 rownum이 뒤엉켜버린다.
------------------------------------------------------------
-- inline view : from 절 뒤에 테이블이 나와야하는데 select 가 나온다는건. select를 (가상)테이블로 보는 것이다.
------------------------------------------------------------
 --order by SALARY desc;
  select
    * , ROWNUM
  from
  (
    select
        *
    from EMPLOYEE
    order by SALARY desc
  ) e
    where ROWNUM<=5;
 ------------------------------------------------------------
  select
    e.* , ROWNUM
  from
  (
    select
        *
    from EMPLOYEE
    order by SALARY desc
  ) e
    where ROWNUM<=5;
--------------------------
--연봉순위 하위 5위부터 1위까지
--------------------------
     select
    e.* , ROWNUM
  from
  (
    select
        *
    from EMPLOYEE
    order by SALARY asc
  ) e
    where ROWNUM<=5;
--------------------------
--연봉순위  1위부터 9위까지
--------------------------
--rownum이 1값이 포함되지 않으면 검색이 안된다.
-- where rownum = 9 는 실행되지 않는다.
-----------------------
     select
    e.* , ROWNUM
  from
  (
    select
        *
    from EMPLOYEE
    order by SALARY desc
  ) e
    where ROWNUM <= 9;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.100 연봉 상위 3~5명의 직원을 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-----------------------
-- 제일 빠른 방법
-----------------------
select
*
from
(
    select
           e.* , ROWNUM "RNUM"
    from (
             select *
             from EMPLOYEE
             order by SALARY desc
         ) e
    where ROWNUM <= 5
)
where RNUM >=3;
-----------------------
-- 제일 빠른 방법보다 두배이상 걸리는 방법
-----------------------
select
*
from
(
    select
           e.* , ROWNUM "RNUM"
    from ( select * from EMPLOYEE order by SALARY desc ) e
)
where RNUM >=3 and RNUM <=5;


/*
----------------------------------------------------
-- n위부터 m위까지의 랭킹 구하는 제일 빠른 방법 공식
----------------------------------------------------
select 보고싶은컬럼명 from (select zxcvb.* , ROWNUM "RNUM" from (
        정렬 select 구문
    ) zxcvb where ROWNUM <= 최대랭킹 ) where RNUM >= 최소랭킹 ;

----------------------------------------------------
-- n위부터 m위까지의 랭킹 구하는 두배 느린 방법 공식
----------------------------------------------------
select 보고싶은컬럼명 from (select zxcvb.* , ROWNUM "RNUM" from (
        정렬 select 구문
    ) zxcvb ) where RNUM >= 최소랭킹 and RNUM <= 최대랭킹  ;
*/

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.101 태어난 순서 연장자 서열 11위부터 20위까지 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
* from ( select zxcvb.* , ROWNUM "RNUM" from
        (select * from employee
        order by decode(substr(JUMIN_NUM,7,1),'1','19','2','19','20')||substr(JUMIN_NUM,1,6) asc )
            zxcvb where ROWNUM <= 20  ) where rnum >=11;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.102 직급 서열 11위~20위 직원 검색하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
* from ( select zxcvb.* , ROWNUM "RNUM" from
        (select * from employee
        order by decode(JIKUP,'사장',1,'부장',2,'과장',3,'대리',4,5) asc , HIRE_DATE asc )
            zxcvb where ROWNUM <= 20  ) where rnum >=11;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.103 (*****)
-- [직원번호], [직원명], [연봉], [연봉 순위] 를 출력하면?
-- 단 [연봉 순위]를 오름차순 유지
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- e1.salary 보다 큰놈이 몇개냐? 거기에 +1을 한다.
-- 홍길동.5000 라면 그보다 많이 받는 행의 개수는 0이므로 +1 하면 그 랭킹 순위가 된다.
    select
         e1.EMP_NO      "직원번호"
        ,e1.EMP_NAME    "직원명"
        ,e1.SALARY      "연봉"
        ,(select count(*)+1 from EMPLOYEE e2 where e2.SALARY > e1.SALARY )   "연봉순위"
    from EMPLOYEE e1
    order by  4;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.104 (*****)
-- [직원번호], [직원명], [주민번호], [출생서열순위] 를 출력하면?
-- 단 [출생서열순위]를 오름차순 유지
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
         e1.EMP_NO      "직원번호"
        ,e1.EMP_NAME    "직원명"
        ,e1.JUMIN_NUM   "주민번호"
        ,(select count(*)+1 from EMPLOYEE e2
        where decode(substr((e2.JUMIN_NUM),7,1),'1','19','2','19','20')||substr((e2.JUMIN_NUM),1,6)
                  <
              decode(substr((e1.JUMIN_NUM),7,1),'1','19','2','19','20')||substr((e1.JUMIN_NUM),1,6)
            )   "출생서열순위"
    from EMPLOYEE e1
    order by  4 asc;
----------------------------------------------
    select
         e1.EMP_NO      "직원번호"
        ,e1.EMP_NAME    "직원명"
        ,e1.JUMIN_NUM   "주민번호"
        ,(select count(*)+1 from EMPLOYEE e2
        where case when substr(e2.JUMIN_NUM,7,1) in('1','2') then'19' else'20'end||substr((e2.JUMIN_NUM),1,6)
                  <
              case when substr(e1.JUMIN_NUM,7,1) in('1','2') then'19' else'20'end||substr((e1.JUMIN_NUM),1,6)
            )   "출생서열순위"
    from EMPLOYEE e1
    order by  4 asc;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.105 (*****)
-- [직원번호], [직원명], [직급], [직급서열순위] 를 출력하면?
-- 단 [직급서열순위]를 오름차순 유지
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- decode : oracle 에서만 가능
-- case : ansi / oracle 둘 다 가능
    select
         e1.EMP_NO      "직원번호"
        ,e1.EMP_NAME    "직원명"
        ,e1.JIKUP       "직급"
        ,(select count(*)+1 from EMPLOYEE e2
          where decode(e2.JIKUP,'사장',1,'부장',2,'과장',3,'대리',4,5)
                   <
                decode(e1.JIKUP,'사장',1,'부장',2,'과장',3,'대리',4,5)
            )   "직급서열순위"
    from EMPLOYEE e1
    order by 4 asc;
----------------------------------------------
    select
         e1.EMP_NO      "직원번호"
        ,e1.EMP_NAME    "직원명"
        ,e1.JIKUP       "직급"
        ,(select count(*)+1 from EMPLOYEE e2
          where case e2.JIKUP when '사장'then 1 when '부장' then 2 when '과장' then 3 when '대리'then 4 else 5 end
                   <
                case e1.JIKUP when '사장'then 1 when '부장' then 2 when '과장' then 3 when '대리'then 4 else 5 end
            )   "직급서열순위"
    from EMPLOYEE e1
    order by 4 asc;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.106 [직원번호], [직원명], [담당고객수] 를 출력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
         e.EMP_NO      "직원번호"
        ,e.EMP_NAME    "직원명"
        ,(select count(*) from CUSTOMER c
          where e.EMP_NO = c.EMP_NO)   "담당고객수"
    from EMPLOYEE e;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.107 아래처럼 [부서명], [부서직원수], [부서담당고객수] 를 출력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
 -- 부서명 | 직원총수 | 담당고객수
 -- ㅡㅡㅡㅡ|ㅡㅡㅡㅡㅡ|ㅡㅡㅡㅡㅡ
 -- 영업부  |  7명   |   4명
 ---------|-------|--------
 -- 전산부  |  7명  |   2명
 ---------|-------|--------
--  총무부  |  6명  |   2명
----------|-------|--------
 -- 자재   |   0명  |   0명
    select
        d.DEP_NAME "부서명"
        ,(select count(*) from EMPLOYEE e where d.DEP_NO = e.DEP_NO )||'명' "직원총수"
        ,(select count(*) from CUSTOMER c , EMPLOYEE e
            where d.DEP_NO = e.DEP_NO and c.EMP_NO = e.EMP_NO )||'명' "담당고객수"
    from dept d
    order by 2 desc;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.108 아래처럼 출력하면? <조건> 담당직원이 없는 고객도 포함
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 1) 오라클 조인
    select
        c.CUS_NO "고객번호"
        ,c.CUS_NAME "고객명"
        ,c.TEL_NUM "고객전화번호"
        ,e.EMP_NAME "담당직원명"
        ,e.JIKUP "담당직원직급"
        ,e.DEP_NO "부서번호"
    from CUSTOMER c ,EMPLOYEE e
    where e.EMP_NO(+) = c.EMP_NO and e.EMP_NO(+) = c.EMP_NO and e.EMP_NO(+) = c.EMP_NO
    order by 1 asc;

-- 2) ansi 조인 사용
    select
        c.CUS_NO "고객번호"
        ,c.CUS_NAME "고객명"
        ,c.TEL_NUM "고객전화번호"
        ,e.EMP_NAME "담당직원명"
        ,e.JIKUP "담당직원직급"
        ,e.DEP_NO "부서번호"
    from CUSTOMER c left outer join EMPLOYEE e
    on e.EMP_NO = c.EMP_NO and e.EMP_NO = c.EMP_NO and e.EMP_NO = c.EMP_NO
    order by 1 asc;

-- 3) 서브쿼리
    select
        c.CUS_NO "고객번호"
        ,c.CUS_NAME "고객명"
        ,c.TEL_NUM "고객전화번호"
        ,(select e.EMP_NAME from EMPLOYEE e where e.EMP_NO = c.EMP_NO) "담당직원명"
        ,(select e.JIKUP from EMPLOYEE e where e.EMP_NO = c.EMP_NO) "담당직원직급"
        ,(select e.DEP_NO from EMPLOYEE e  where e.EMP_NO = c.EMP_NO ) "부서번호"
    from CUSTOMER c
    order by 1 asc;



--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.109 아래처럼 출력하면?
-- <조건> 담당직원이 없는 고객도 포함, 직원은 10번부서 직원만 출력하기
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 서브쿼리
    select
        c.CUS_NO "고객번호"
        ,c.CUS_NAME "고객명"
        ,c.TEL_NUM "고객전화번호"
        ,(select e.EMP_NAME from EMPLOYEE e where e.EMP_NO = c.EMP_NO and e.DEP_NO = 10) "담당직원명"
        ,(select e.JIKUP from EMPLOYEE e where e.EMP_NO = c.EMP_NO and e.DEP_NO = 10) "담당직원직급"
        ,(select e.DEP_NO from EMPLOYEE e  where e.EMP_NO = c.EMP_NO and e.DEP_NO = 10) "부서번호"
    from CUSTOMER c
    order by 1 asc;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 4. group by 문제 ******
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- group 을 지어서 통계 관련 데이터를 내놓을 때 사용하는 키워드이다.
--------------------------------------------------------
-- group by 를 사용하여 나온 통계 자료는 회사 차원에서 현재 상태를 파악하고
-- 미래를 예측할 때 사용하므로 무척 중요한 자료이다.
-- group by 사용 시 함수가 많이 등장하므로 group by 실력은 함수를 사용에 달려있다.
--------------------------------------------------------
-- 예) 직급별 평균 연봉
-- 예) 부서별 평균 연봉
-- 예) 남녀별 평균 연봉
-- 예) 나이대별 평균 연봉

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.110 부서별로 [부서번호], [급여합계], [평균급여], [인원수]를 츨력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
        dep_no                  "부서번호"
        ,sum(salary)            "급여합계"
        ,round(avg(SALARY),0)   "평균급여"
        ,count(*)               "인원수"
    from EMPLOYEE
    group by  dep_no;
    --------------------
    --select 절에 일반컬럼과 그룹함수컬럼이 등장하면
    --group by 뒤에는 반드시 그룹 지을 일반 컬럼이 나와야한다.


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.111 부서별로 [직급], [급여합계], [평균급여], [인원수]를 츨력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
        DEP_NO
        , JIKUP
        , sum(SALARY)
        , round(avg(SALARY))
        , count(*) || '명'
    from EMPLOYEE
    group by jikup , DEP_NO;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.112 부서별, 직급별 , [부서번호] [직급], [급여합계], [평균급여], [인원수]를 츨력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
        DEP_NO "부서번호"
        ,JIKUP "직급"
        ,sum(SALARY) "급여합계"
        , round(avg(SALARY)) "평균급여"
        , count(*) "인원수"
    from EMPLOYEE
    group by dep_no, JIKUP
    order by 1 asc;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.113 부서별, 직급별 , [부서번호] [직급], [급여합계], [평균급여], [인원수]를 츨력하되
-- 인원수는 3명 이상을 출력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
----------------------------
-- inline view 사용
----------------------------
-- group by 행 내에서는 where는 사용할 수 없다.
-- group by 의 결과물을 inline view 로 보고 행을 where 절로 골라내고 있다.
-- 인라인 뷰로 들어가면 테이블로 보는데 정식 테이블로 위장시키려면 컬럼명을 정확하게 영어로 대문자로 정해야한다.
-- 그래야 바깥에서는 테이블로 보기때문에 alias를 정식 컬럼명으로 사용할 수 있도록 alias를 "대문자"로 컬럼명을 정해야한다.
    select *
    from
    (
        select
            DEP_NO                 "DEP_NO"
            ,JIKUP                 "JIKUP"
            ,sum(SALARY)           "SUM_SALARY"
            ,round(avg(SALARY))    "AVG_SALARY"
            ,count(*)              "CNT"
        from EMPLOYEE
        group by dep_no, JIKUP
    )
    where CNT >= 3;
----------------------------
--having 사용
----------------------------
-- group by 의 결과물에서 행을 골라낼 때 사용한다.
-- group by 의 결과물에서 행을 골라낼 때 where 는 사용할 수 없다.
    select
        DEP_NO                 "DEP_NO"
        ,JIKUP                 "JIKUP"
        ,sum(SALARY)           "SUM_SALARY"
        ,round(avg(SALARY))    "AVG_SALARY"
        ,count(*)              "CNT"
    from EMPLOYEE
    group by dep_no, JIKUP

    having count(*) >= 3;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.114 부서별, 성별 , [부서번호] [성], [급여합계], [평균급여], [인원수]를 츨력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 함수를 group by에  그대로 같다 붙인다.
-----------------------------------
    select
        DEP_NO                                                                  "부서번호"
        , case when substr(JUMIN_NUM,7,1) in('1','3') then '남' else '여' end    "성별"
        ,sum(SALARY)                                                            "급여합계"
        ,round(avg(SALARY))                                                     "평균급여"
        ,count(*)                                                               "인원수"
    from EMPLOYEE
    group by
         DEP_NO
        ,case when substr(JUMIN_NUM,7,1) in('1','3') then '남' else '여' end
    order by 5 desc;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.115 입사연도별 [입사년도], [인원수]를 츨력하고 년도별로 오름차순하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
        to_char(HIRE_DATE,'YYYY')||'년'     "입사년도"
        ,count(*)||'명'                     "인원수"
    from EMPLOYEE
    group by to_char(HIRE_DATE,'YYYY')
    order by "입사년도" asc;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.116 [직원명], [출생년도](년-월-일), [나이]를 츨력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
EMP_NAME
,case when substr(JUMIN_NUM,7,1) in('1','2') then '19'
          else '20' end || substr(JUMIN_NUM,1,2)||'년'||
                            substr(JUMIN_NUM,3,2)||'월'||
                            substr(JUMIN_NUM,5,2)||'일'
    "출생년도"
,extract(year from sysdate) -
      to_number(
          case when substr(JUMIN_NUM,7,1) in('1','2') then '19'
          else '20' end || substr(JUMIN_NUM,1,2)
          )+1 ||'살' "나이"

from EMPLOYEE;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.117 부서별로 [부서번호], [평균근무년수]를 츨력하면? (근년수 소수2째자리에서 반올림)
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
DEP_NO "부서명"
,to_char(avg((sysdate-HIRE_DATE)/365),'99.99')||'년' "평균근무년수"
from EMPLOYEE
group by DEP_NO;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.118 입사분기별로 [입사분기], [인원수]를 츨력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
to_char(HIRE_DATE,'Q')||'분기' "입사분기"
,count(*)||'명'                "인원수"
from EMPLOYEE
group by to_char(HIRE_DATE,'Q')
order by 1 asc;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.119 입사분기별로 [입사분기], [인원수]를 츨력하면? 단 1분기만 보여라.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
to_char(HIRE_DATE,'Q')||'분기' "입사분기"
,count(*)||'명'                "인원수"
from EMPLOYEE
group by to_char(HIRE_DATE,'Q')
having to_char(HIRE_DATE,'Q') = 1;
-----------------------
select *
from
(
    select to_char(HIRE_DATE, 'Q') ||'분기' "QUTER"
         , count(*) || '명'                 "CNT"
    from EMPLOYEE
    group by to_char(HIRE_DATE, 'Q')
)
where QUTER = 1 ||'분기';


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.120 입사연대별, 성별로 [입사연대], [성별], [연대별입사자수]를 츨력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
to_char(HIRE_DATE,'YYYY') "입사연대"
, case when substr(JUMIN_NUM,7,1) in('1','3') then '남' else '여' end    "성별"
,count(*) ||'명' "연대별입사자수"

from EMPLOYEE
group by to_char(HIRE_DATE,'YYYY')
       ,case when substr(JUMIN_NUM,7,1) in('1','3') then '남' else '여' end
order by 1 asc;


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.121 [직원명], [입사일](년-월-일/~/4분기~요일), [퇴직일](년~월~일)을 츨력하면?
-- 조건 - 퇴직일은 입사 후 20년 5개월 10일 후
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
select
EMP_NAME
,to_char(HIRE_DATE,'YYYY-MM-DD-Q')||'/4분기-'||to_char(HIRE_DATE,'DAY')
from EMPLOYEE

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- Q.122 직원이 있는 부서별로 [부서번호], [부서위치], [직원수]를 출력하면?
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm