# JK UVM 프로젝트 로드맵

현재 진행 중: **WEEK6 (11/17‒11/21)**  
JK UVM 프로젝트는 UVM(Universal Verification Methodology)을 기반으로 UBUS 프로토콜을 검증하기 위한 VIP(Verification IP) 구축 및 테스트벤치 개발 프로젝트입니다.
매주 월요일 진행 상황 공유, 목요일 이슈 해결 및 보고를 진행하고 있습니다.

---

## 프로젝트 개요 (Overview)

검증 대상 (DUT): UBUS Protocol (Master/Slave Architecture)

검증 방법: UVM 1.2 (SystemVerilog)

주요 기능:

Configurable Master/Slave Agent

Virtual Sequencer를 이용한 시나리오 제어

Scoreboard를 통한 데이터 무결성 검증

Coverage Driven Verification (목표 100%)

참고: .gitignore 설정에 의해 시뮬레이션 생성물(*.log, *.fsdb, csrc/ 등)은 업로드되지 않습니다.

## 저희 폴더 처음에 사용하실 때
- git clone 하시면 처음에 밑 git tree와 같이 폴더 생성됩니다.

---

## 현재 git tree
├── JK_vip\
│   ├── sim\
│   └── sv\
├── jeong\
│   └── missions\
├── kwon\
├── week2\
│   ├── dongo\
│   └── jeong\
├── week3\
│   ├── dong\
│   └── jeong\
├── week4\
│   ├── master\
│   └── verdiLog\
├── week5\
│   ├── JK_vip\
│   ├── master\
│   └── slave\
└── week6\
    └── JK_vip\
---

## 시작하기 (Getting Started)

1. 필수 환경 (Prerequisites)

이 프로젝트를 실행하기 위해서는 다음 툴이 필요합니다.

OS: Linux (CentOS/RHEL 권장)

Simulator: Synopsys VCS (Ver O-2018.09-SP2 이상)

Debug: Synopsys Verdi

UVM Version: 1.2


## 클론한 뒤 실행 순서(flow)
```
# 1) 저장소 받기
git clone ssh://git@gitlab.sogang.com:10022/uvm_tb_project/jk.git
cd jk

# 2) 시뮬레이션 디렉터리로 이동
cd JK_vip/sim

# 3) 빌드/실행 
make all (clean, run, simv 다 실행)


# 4) 파형 보기 (Verdi)
verdi -ssf test.fsdb
```


---
### 자주 사용하는 명령어

| 명령 | 핵심 기능 | 자주 쓰는 예시 | 비고/주의 |
| --- | --- | --- | --- |
| `git add` | 변경 파일을 스테이징 | `git add .`, `git add path/file` | 커밋 대상 선택 단계 |
| `git commit` | 스테이징 내용 스냅샷 저장 | `git commit -m "feat: ..."` | 메시지는 의미 있게 |
| `git commit --amend` | 직전 커밋 수정 | `git commit --amend -m "fix: ..."` | 이미 푸시한 커밋 수정 시 강제 푸시 필요 |
| `git checkout` | 브랜치/커밋으로 작업 트리 전환 | `git checkout main`, `git checkout <commit>` | 최신은 `git switch`/`git restore`도 사용 |
| `git checkout -b` | 새 브랜치 생성+전환 | `git checkout -b feature/login` | = `git branch` + `git checkout` |
| `git rebase` | 커밋들을 다른 베이스 위로 재배치 | `git rebase main` | 히스토리 깔끔, 충돌 해결 필요 |
| `git merge` | 두 브랜치 이력 병합 | `git merge feature/login` | 기본은 3-way merge |
| `git cherry-pick` | 특정 커밋만 골라 적용 | `git cherry-pick <hash>` | 선택적 이식 |
| `git branch -f` | 브랜치 포인터 강제 이동 | `git branch -f dev <hash>` | 히스토리 재정렬 시 유용 |
| `git fetch` | 원격에서 참조/커밋만 받아오기 | `git fetch`, `git fetch origin main` | 로컬 작업트리는 변경 없음 |
| `git pull` | 원격 변경 가져와 병합/리베이스 | `git pull`, `git pull --rebase` | = fetch + merge(기본) / `--rebase` 추천 |
| `git pull --rebase` | 가져온 뒤 리베이스로 반영 | `git pull --rebase origin main` | 이력 깔끔 |
| `git push` | 로컬 커밋을 원격에 반영 | `git push`, `git push -u origin main` | 최초 푸시에 `-u`로 업스트림 설정 |
| `git push origin <src>:<dst>` | 리모트 RefSpec 푸시 | `git push origin feature:feature` | 로컬/원격 이름 다를 때 |
| `git fetch origin <src>:<dst>` | 가져오며 로컬 ref에 저장 | `git fetch origin main:tmp-main` | 원격 브랜치를 로컬 새 ref로 |
| `git checkout ^`, `~` | 상대 참조로 이동 | `git checkout HEAD^` (부모 1), `git checkout HEAD~2` (2단계 전) | `^2`는 두 번째 부모(머지 커밋) |
---



## 프로젝트 캘린더

| Week | Date Range | Mon | Tue | Wed | Thu | Fri |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **WEEK1** | 10/13‒10/17 | 시스템베릴로그 수업 | 시스템베릴로그 수업 | 시스템베릴로그 수업 | UVM 수업 | UVM 수업 |
| **WEEK2** | 10/20‒10/24 | UVM TB 구조 점검<br/>시뮬레이터/라이브러리 버전 확정 | Git 기본 명령어 정리 | 파일·폴더 네이밍 정리<br/>`env`/`test_base`/`tb_top`/`transfer` 작성 | 파형 미출력 원인 분석·질의응답으로 해결 | 워크로드 정리<br/>WEEK3 리소스 준비 |
| **WEEK3** | 10/27‒10/31 | UBUS 인터페이스·transfer 정의<br/>(`week3/dong/jk_ubus_interface.sv`<br/>`week3/jeong/jk_ubus_if.sv`<br/>`week3/dong/jk_ubus_transfer.sv`) | Master 에이전트 구성(Agent/Driver/Sequencer/Sequence) 작성<br/>(`week3/dong/jk_ubus_master_agent.sv`<br/>`jk_ubus_master_driver.sv`<br/>`jk_ubus_master_sequence.sv`<br/>`jk_ubus_master_sequencer.sv`) | Master 환경 통합(Test/Env/TB-Top)<br/>(`week3/dong/jk_ubus_master_env.sv`<br/>`jk_ubus_master_test.sv`<br/>`jk_ubus_tb_top.sv`) | Slave 구성요소 작성(Agent/Driver/Monitor) 및 정비(Sequence/Env/PKG/TB-Top)<br/>(`week3/jeong/jk_ubus_slave_agent.sv`<br/>`jk_ubus_slave_driver.sv`<br/>`jk_ubus_slave_monitor.sv`<br/>`jk_ubus_slave_sequence.sv`<br/>`jk_ubus_slave_env.sv`<br/>`jk_ubus_pkg.sv`<br/>`jk_ubus_tb_top.sv`) | WEEK4 소스 준비<br/>WEEK3 복습 |
| **WEEK4** | 11/03‒11/07 | WEEK4 계획 수립·이론 수업 | Slave/Master 파일 작성 및 구조 정리 | 신호 파형 분석(리셋·핸드셰이크 중심) | 교수님·조교님 Q&A로 이슈 해결<br/>README 업데이트 | Master/Slave 통합환경완성성 |
| **WEEK5** | 11/10‒11/14 | ScoreBoard 계획, 코드작성 | ScoreBoard 디버깅 및 Virtual sequence 정리 | ScoreBoard 완성 및 Virtual sequence 코드 작성 | Virtual sequence 작성 완료 후 파형 확인 | Virtual sequence 디버깅 및 완성, README 파일 수정 |
| **WEEK6** | 11/17‒11/21 | Coverage 강의 수강 | Scoreboard & Slave Driver 연결<br/>파형 확인<br/>Coverage 100% 달성<br/>README 작성 | Scoreboard & Slave Driver 연결<br/>파형 확인<br/>Coverage 100% 달성<br/>README 작성 | Reactive Slave Architecture 강의 수강 | Scoreboard & Slave Driver 연결<br/>파형 확인<br/>Coverage 100% 달성<br/>README 작성 |
| **WEEK7** | 11/24‒11/28 | * | * | * | * | * |

---

## 진행 전략
- **리스크 관리**: 시뮬레이터 버전, 라이브러리 잘 확인합니다.
- **지속적 통합**: GIT LAB으로 수정할 때마다 통합합니다.

---

## 항상 열심히!

## UVM Libraries 구조도
[ChipVerify](https://www.chipverify.com/uvm/uvm-introduction)*

