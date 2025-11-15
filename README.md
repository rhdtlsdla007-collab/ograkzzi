# JK UVM 프로젝트 로드맵

현재 진행 중: **WEEK3 (10/27‒10/31)**  
프로젝트 기간 동안 매주 월요일 오전에 진행 상황을 공유 및 금주에 어떻게 할 지 정리, 목요일에는 프로젝트 진행상황 보고 및 문제 해결.

---

## 저희 폴더 처음에 사용하실 때
- git clone 하시면 처음에 밑 git tree와 같이 폴더 생성됩니다.
- 참고) .gitignore 파일 보시면 시뮬레이션 후 나오는 산출물 들은 무시하는 것을 알 수 있습니다.
---

## 현재 git tree
└── jk\
    ├── JK_vip\
    │   ├── sim\
    │   └── sv\
    ├── week2\
    │   ├── dongo\
    │   └── jeong\
    ├── week3\
    │   ├── dong\
    │   └── jeong\
    └── week4\
        ├── master\
        └── verdiLog
---

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

| Week  | Date Range  | Mon                                                                                                                           | Tue                                                                                                                                                                                    | Wed                                                                                                                   | Thu                                                                                                                                                                                                                                                             | Fri                      |
| ----- | ----------- | ----------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| WEEK1 | 10/13‒10/17 | 시스템베릴로그 수업                                                                                                                    | 시스템베릴로그 수업                                                                                                                                                                             | 시스템베릴로그 수업                                                                                                            | UVM 수업                                                                                                                                                                                                                                                          | UVM 수업                   |
| WEEK2 | 10/20‒10/24 | UVM TB 구조 점검<br/>시뮬레이터/라이브러리 버전 확정                                                                                            | Git 기본 명령어 정리                                                                                                                                                                          | 파일·폴더 네이밍 정리<br/>`env`/`test_base`/`tb_top`/`transfer` 작성                                                             | 파형 미출력 원인 분석·질의응답으로 해결                                                                                                                                                                                                                                          | 워크로드 정리<br/>WEEK3 리소스 준비 |
| WEEK3 | 10/27‒10/31 | UBUS 인터페이스·transfer 정의<br/>(`week3/dong/jk_ubus_interface.sv`, `week3/jeong/jk_ubus_if.sv`, `week3/dong/jk_ubus_transfer.sv`) | Master 에이전트 구성(Agent/Driver/Sequencer/Sequence) 작성<br/>(`week3/dong/jk_ubus_master_agent.sv`, `jk_ubus_master_driver.sv`, `jk_ubus_master_sequence.sv`, `jk_ubus_master_sequencer.sv`) | Master 환경 통합(Test/Env/TB-Top)<br/>(`week3/dong/jk_ubus_master_env.sv`, `jk_ubus_master_test.sv`, `jk_ubus_tb_top.sv`) | Slave 구성요소 작성(Agent/Driver/Monitor) 및 정비(Sequence/Env/PKG/TB-Top)<br/>(`week3/jeong/jk_ubus_slave_agent.sv`, `jk_ubus_slave_driver.sv`, `jk_ubus_slave_monitor.sv`, `jk_ubus_slave_sequence.sv`, `jk_ubus_slave_env.sv`, `jk_ubus_pkg.sv`, `jk_ubus_tb_top.sv`) | WEEK4 소스 준비<br/>WEEK3 복습 |
| WEEK4 | 11/03‒11/07 | WEEK4 계획 수립·이론 수업                                                                                                             | Slave/Master 파일 작성 및 구조 정리                                                                                                                                                             | 신호 파형 분석(리셋·핸드셰이크 중심)                                                                                                 | 교수님·조교님 Q&A로 이슈 해결<br/>README 업데이트                                                                                                                                                                                                                              | *                        |

| WEEK5 | 11/10‒11/14 | * | * | * | * | * |
| WEEK6 | 11/17‒11/21 | * | * | * | * | * |
| WEEK7 | 11/24‒11/28 | * | * | * | * | * |

---

## 진행 전략
- **리스크 관리**: 시뮬레이터 버전, 라이브러리 잘 확인합니다.
- **지속적 통합**: GIT LAB으로 수정할 때마다 통합합니다.

---

## 노션 링크
- 저희 프로젝트 수행을 더 자세히 보려면 밑 링크로 들어가서 보시면 됩니다.
 
- [JK노션](https://www.notion.so/JK-200ed57114c080738170e8655d2f9983)

---

## 항상 열심히!

## UVM Libraries 구조도

![UVM Libraries 구조도](./images/uvm-class-hierarchy.png)

*이미지 출처: [ChipVerify](https://www.chipverify.com/uvm/uvm-introduction)*

# UVM 커버리지: `cov_trans` vs `cov_trans_beat` 쉬운 설명

## 핵심 개념

두 개의 `covergroup`은 모두 **UBUS 통신 트랜잭션**이 어떤 종류로 발생했는지를 기록합니다. 하지만 **무엇을 측정하는가**가 다릅니다.

---

## `cov_trans`: 트랜잭션 전체 특성 측정

### 어떤 정보를 수집하나?

하나의 UBUS 메시지(트랜잭션)가 발생했을 때, 그 메시지의 전체 특성을 기록합니다.

### 측정하는 항목

| 측정 항목 | 의미 |
| -------- | ---- |
| **`trans_addr`** | 메시지가 시작되는 메모리 주소의 범위 |
| **`trans_dir`** | 읽기(Read)인지 쓰기(Write)인지 |
| **`trans_size`** | 메시지 크기 (1, 2, 4, 8 바이트 중 하나) |
| **`trans_addrXdir`** | 특정 주소에서 읽기/쓰기가 모두 발생했는지 확인 |
| **`trans_dirXsize`** | 다양한 크기의 읽기/쓰기가 발생했는지 확인 |

### 예시

```
트랜잭션 1: 0x1000 주소에서 4바이트를 읽기
  → trans_addr = "0x1000~0x2000", trans_dir = "Read", trans_size = "4B"

트랜잭션 2: 0x1000 주소에 2바이트를 쓰기
  → trans_addr = "0x1000~0x2000", trans_dir = "Write", trans_size = "2B"
```

### 세분성 (Granularity)

**트랜잭션 단위**: 하나의 메시지가 들어올 때마다 **한 번에** 그 메시지의 특성을 전부 기록합니다.

---

## `cov_trans_beat`: 트랜잭션 내 개별 데이터 측정

### 어떤 정보를 수집하나?

트랜잭션의 **세부 데이터 값**까지 기록합니다. 특히 실제로 어떤 값이 전달되었는지를 중점으로 측정합니다.

### 측정하는 항목

| 측정 항목 | 의미 |
| -------- | ---- |
| **`beat_addr`** | 데이터가 전송되는 주소 |
| **`beat_dir`** | 읽기인지 쓰기인지 |
| **`beat_data`** | 실제로 전송된 **데이터 값** (예: 0x12, 0xFF 등) |
| **`beat_addrXdir`** | 특정 주소에서 읽기/쓰기 조합 |
| **`beat_addrXdata`** | 특정 주소에 특정 데이터 값이 쓰여졌는지 확인 |

### 예시

```
트랜잭션: 0x1000 주소에 [0x12, 0x34, 0x56, 0x78]을 쓰기

cov_trans_beat는:
  → beat_addr = 0x1000, beat_dir = Write, beat_data = 0x12 (첫 번째 데이터)
     (현재는 첫 번째 데이터만 기록)
```

### 세분성 (Granularity)

**데이터 비트 단위**: 트랜잭션의 각 데이터 요소에 대해 세부적으로 기록합니다.

---

## 두 커버리지의 차이 비교

| 비교 항목 | `cov_trans` | `cov_trans_beat` |
| --------- | ----------- | --------------- |
| **초점** | 트랜잭션의 **주요 속성** | 트랜잭션의 **실제 데이터 값** |
| **측정 대상** | 주소, 읽기/쓰기 방향, 크기 | 주소, 읽기/쓰기 방향, **데이터 값** |
| **세분성** | 트랜잭션 1개 = 1번 측정 | 데이터 1개 = 1번 측정 (현재는 첫 번째만) |
| **목적** | "어떤 종류의 메시지들이 발생했나?" | "어떤 값들이 전송되었나?" |

---

## 실생활 비유

**편지 배송 시스템**으로 생각해보세요:

- **`cov_trans`**: 배송된 편지의 "발송지, 도착지, 크기"를 기록
  - 예: "서울에서 부산으로 10kg 편지 배송됨"
  - 편지의 내용(데이터)은 신경 안 씀

- **`cov_trans_beat`**: 편지의 "발송지, 도착지, **실제 내용**"까지 기록
  - 예: "서울에서 부산으로 '안녕하세요'라는 내용의 편지 배송됨"
  - 어떤 **구체적인 내용**이 전달되었는지 중요함

---

## 현재 상태의 문제점

`cov_trans_beat`는 현재 **첫 번째 데이터(`tr.data[0]`)만** 측정합니다.

만약 트랜잭션이 여러 데이터 값을 포함한다면:

```
트랜잭션: [0x12, 0x34, 0x56, 0x78] 4개 데이터

현재 상태: 0x12만 측정 (첫 번째 데이터)
모든 데이터를 측정하려면: write 함수를 수정해서 
각 데이터(0x34, 0x56, 0x78)도 따로 측정해야 함
```

---

## 요약

- **`cov_trans`**: "**어떤 종류의** 트랜잭션이 발생했나?" → 트랜잭션의 **전체 특성** 측정
- **`cov_trans_beat`**: "**어떤 값이** 전송되었나?" → 트랜잭션의 **세부 데이터** 측정

두 커버리지는 **상보적** (서로 보완)입니다. 둘 다 높은 커버리지를 달성해야 검증이 충분합니다!