# oracle_subquery_groupby
오라클 서브쿼리+그룹바이 예제


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
    where SALARY >= (select avg(salary) from EMPLOYEE) and SALARY<(select max(SALARY) from EMPLOYEE);

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
    -- 모든 셀릭트문에 슬쩍 넣어주는 (oracle)서비스용 컬럼이다.
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
    --연봉순위 1위부터 9위까지
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
    ) zxcvb ) where RNUM >= 최소랭킹 and RNUM <= 최대랭킹 ;
    */

    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.101 태어난 순서 연장자 서열 11위부터 20위까지 검색하면?
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
    * from ( select zxcvb.* , ROWNUM "RNUM" from
    (select * from employee
    order by decode(substr(JUMIN_NUM,7,1),'1','19','2','19','20')||substr(JUMIN_NUM,1,6) asc )
    zxcvb where ROWNUM <= 20 ) where rnum >=11;

    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.102 직급 서열 11위~20위 직원 검색하면?
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
    * from ( select zxcvb.* , ROWNUM "RNUM" from
    (select * from employee
    order by decode(JIKUP,'사장',1,'부장',2,'과장',3,'대리',4,5) asc , HIRE_DATE asc )
    zxcvb where ROWNUM <= 20 ) where rnum >=11;


    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.103 (*****)
    -- [직원번호], [직원명], [연봉], [연봉 순위] 를 출력하면?
    -- 단 [연봉 순위]를 오름차순 유지
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- e1.salary 보다 큰놈이 몇개냐? 거기에 +1을 한다.
    -- 홍길동.5000 라면 그보다 많이 받는 행의 개수는 0이므로 +1 하면 그 랭킹 순위가 된다.
    select
    e1.EMP_NO "직원번호"
    ,e1.EMP_NAME "직원명"
    ,e1.SALARY "연봉"
    ,(select count(*)+1 from EMPLOYEE e2 where e2.SALARY > e1.SALARY ) "연봉순위"
    from EMPLOYEE e1
    order by 4;


    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.104 (*****)
    -- [직원번호], [직원명], [주민번호], [출생서열순위] 를 출력하면?
    -- 단 [출생서열순위]를 오름차순 유지
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
    e1.EMP_NO "직원번호"
    ,e1.EMP_NAME "직원명"
    ,e1.JUMIN_NUM "주민번호"
    ,(select count(*)+1 from EMPLOYEE e2
    where decode(substr((e2.JUMIN_NUM),7,1),'1','19','2','19','20')||substr((e2.JUMIN_NUM),1,6)
    <
    decode(substr((e1.JUMIN_NUM),7,1),'1','19','2','19','20')||substr((e1.JUMIN_NUM),1,6)
    ) "출생서열순위"
    from EMPLOYEE e1
    order by 4 asc;
    ----------------------------------------------
    select
    e1.EMP_NO "직원번호"
    ,e1.EMP_NAME "직원명"
    ,e1.JUMIN_NUM "주민번호"
    ,(select count(*)+1 from EMPLOYEE e2
    where case when substr(e2.JUMIN_NUM,7,1) in('1','2') then'19' else'20'end||substr((e2.JUMIN_NUM),1,6)
    <
    case when substr(e1.JUMIN_NUM,7,1) in('1','2') then'19' else'20'end||substr((e1.JUMIN_NUM),1,6)
    ) "출생서열순위"
    from EMPLOYEE e1
    order by 4 asc;

    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.105 (*****)
    -- [직원번호], [직원명], [직급], [직급서열순위] 를 출력하면?
    -- 단 [직급서열순위]를 오름차순 유지
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- decode : oracle 에서만 가능
    -- case : ansi / oracle 둘 다 가능
    select
    e1.EMP_NO "직원번호"
    ,e1.EMP_NAME "직원명"
    ,e1.JIKUP "직급"
    ,(select count(*)+1 from EMPLOYEE e2
    where decode(e2.JIKUP,'사장',1,'부장',2,'과장',3,'대리',4,5)
    <
    decode(e1.JIKUP,'사장',1,'부장',2,'과장',3,'대리',4,5)
    ) "직급서열순위"
    from EMPLOYEE e1
    order by 4 asc;
    ----------------------------------------------
    select
    e1.EMP_NO "직원번호"
    ,e1.EMP_NAME "직원명"
    ,e1.JIKUP "직급"
    ,(select count(*)+1 from EMPLOYEE e2
    where case e2.JIKUP when '사장'then 1 when '부장' then 2 when '과장' then 3 when '대리'then 4 else 5 end
    <
    case e1.JIKUP when '사장'then 1 when '부장' then 2 when '과장' then 3 when '대리'then 4 else 5 end
    ) "직급서열순위"
    from EMPLOYEE e1
    order by 4 asc;

    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.106 [직원번호], [직원명], [담당고객수] 를 출력하면?
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
    e.EMP_NO "직원번호"
    ,e.EMP_NAME "직원명"
    ,(select count(*) from CUSTOMER c
    where e.EMP_NO = c.EMP_NO) "담당고객수"
    from EMPLOYEE e;


    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.107 아래처럼 [부서명], [부서직원수], [부서담당고객수] 를 출력하면?
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- 부서명 | 직원총수 | 담당고객수
    -- ㅡㅡㅡㅡ|ㅡㅡㅡㅡㅡ|ㅡㅡㅡㅡㅡ
    -- 영업부 | 7명 | 4명
    ---------|-------|--------
    -- 전산부 | 7명 | 2명
    ---------|-------|--------
    -- 총무부 | 6명 | 2명
    ----------|-------|--------
    -- 자재 | 0명 | 0명
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
    ,(select e.DEP_NO from EMPLOYEE e where e.EMP_NO = c.EMP_NO ) "부서번호"
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
    ,(select e.DEP_NO from EMPLOYEE e where e.EMP_NO = c.EMP_NO and e.DEP_NO = 10) "부서번호"
    from CUSTOMER c
    order by 1 asc;


    group by : 그룹을 지어서 결과를 내놓을 때 사용하는 키워드이다.

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
    dep_no "부서번호"
    ,sum(salary) "급여합계"
    ,round(avg(SALARY),0) "평균급여"
    ,count(*) "인원수"
    from EMPLOYEE
    group by dep_no;
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
    DEP_NO "DEP_NO"
    ,JIKUP "JIKUP"
    ,sum(SALARY) "SUM_SALARY"
    ,round(avg(SALARY)) "AVG_SALARY"
    ,count(*) "CNT"
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
    DEP_NO "DEP_NO"
    ,JIKUP "JIKUP"
    ,sum(SALARY) "SUM_SALARY"
    ,round(avg(SALARY)) "AVG_SALARY"
    ,count(*) "CNT"
    from EMPLOYEE
    group by dep_no, JIKUP

    having count(*) >= 3;

    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.114 부서별, 성별 , [부서번호] [성], [급여합계], [평균급여], [인원수]를 츨력하면?
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- 함수를 group by에 그대로 같다 붙인다.
    -----------------------------------
    select
    DEP_NO "부서번호"
    , case when substr(JUMIN_NUM,7,1) in('1','3') then '남' else '여' end "성별"
    ,sum(SALARY) "급여합계"
    ,round(avg(SALARY)) "평균급여"
    ,count(*) "인원수"
    from EMPLOYEE
    group by
    DEP_NO
    ,case when substr(JUMIN_NUM,7,1) in('1','3') then '남' else '여' end
    order by 5 desc;

    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.115 입사연도별 [입사년도], [인원수]를 츨력하고 년도별로 오름차순하면?
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
    to_char(HIRE_DATE,'YYYY')||'년' "입사년도"
    ,count(*)||'명' "인원수"
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
    ,count(*)||'명' "인원수"
    from EMPLOYEE
    group by to_char(HIRE_DATE,'Q')
    order by 1 asc;


    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.119 입사분기별로 [입사분기], [인원수]를 츨력하면? 단 1분기만 보여라.
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
    to_char(HIRE_DATE,'Q')||'분기' "입사분기"
    ,count(*)||'명' "인원수"
    from EMPLOYEE
    group by to_char(HIRE_DATE,'Q')
    having to_char(HIRE_DATE,'Q') = 1;
    -----------------------
    select *
    from
    (
    select to_char(HIRE_DATE, 'Q') ||'분기' "QUTER"
    , count(*) || '명' "CNT"
    from EMPLOYEE
    group by to_char(HIRE_DATE, 'Q')
    )
    where QUTER = 1 ||'분기';


    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    -- Q.120 입사연대별, 성별로 [입사연대], [성별], [연대별입사자수]를 츨력하면?
    --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    select
    to_char(HIRE_DATE,'YYYY') "입사연대"
    , case when substr(JUMIN_NUM,7,1) in('1','3') then '남' else '여' end "성별"
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
