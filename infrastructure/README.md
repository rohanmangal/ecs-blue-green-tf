## Deployment Steps:

**Blue Green Deployment(All-at-once)**

Step 1:  Initial Deployment
| Listner                  |   | Target Groups       | weight |   | Task Sets           |
|--------------------------|---|---------------------|--------|---|---------------------|
| Prod Listener(80 port)   | > | TargetGroup1(blue)  | 100%   | > | Original taskset    |
|                          | > | TargetGroup2(green) | 0%     | > |                     |
|                          |   |                     |        |   |                     |
| Test Listener(9000 port) | > | TargetGroup1(blue)  | 0%     | > | Original taskset    |
|                          | > | TargetGroup2(green) | 100%   | > |                     |

Step 2:  Deploy Replacement taskset and test deployment on ALB:9000
| Listner                  |   | Target Groups       | weight |   | Task Sets           |
|--------------------------|---|---------------------|--------|---|---------------------|
| Prod Listener(80 port)   | > | TargetGroup1(blue)  | 100%   | > | Original taskset    |
|                          | > | TargetGroup2(green) | 0%     | > | Replacement taskset |
|                          |   |                     |        |   |                     |
| Test Listener(9000 port) | > | TargetGroup1(blue)  | 0%     | > | Original taskset    |
|                          | > | TargetGroup2(green) | 100%   | > | Replacement taskset |

Step 3:  Flip traffic from TargetGroup1(blue) to TargetGroup2(green) and mark it to Primary.
| Listner                  |   | Target Groups       | weight |   | Task Sets           |
|--------------------------|---|---------------------|--------|---|---------------------|
| Prod Listener(80 port)   | > | TargetGroup1(blue)  | 0%     | > | Original taskset    |
|                          | > | TargetGroup2(green) | 100%   | > | Replacement taskset |
|                          |   |                     |        |   |                     |
| Test Listener(9000 port) | > | TargetGroup1(blue)  | 100%   | > | Original taskset    |
|                          | > | TargetGroup2(green) | 0%     | > | Replacement taskset |

Step 4:  Delete Original taskset.
| Listner                  |   | Target Groups       | weight |   | Task Sets           |
|--------------------------|---|---------------------|--------|---|---------------------|
| Prod Listener(80 port)   | > | TargetGroup1(blue)  | 0%     | > |                     |
|                          | > | TargetGroup2(green) | 100%   | > | Replacement taskset |
|                          |   |                     |        |   |                     |
| Test Listener(9000 port) | > | TargetGroup1(blue)  | 100%   | > |                     |
|                          | > | TargetGroup2(green) | 0%     | > | Replacement taskset |

TODO for canary and linear deployment
