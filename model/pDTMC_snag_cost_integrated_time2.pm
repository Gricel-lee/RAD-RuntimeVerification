dtmc

// Constants
const double C_S2;
const double C_S8;
const double R_S7;
const double BASE_REWARD_S3;
const double P1 = 0.4;
const double P2;
const double P3;
const double P4;
const double P5;
const double P6;
const double P7;
const double P8;
const double P9;
const double p10;
const int MAX_TIME_TRAJECTORY;
const int MAX_TIME;

// State module
module robot_assisted_dressing
    s : [0..9] init 0;
    t : [0..MAX_TIME] init 0;
    time_step : [0..MAX_TIME] init 0;
    trajectory_complete : bool init false;

    // S0 transitions
    [] s=0 & time_step < MAX_TIME_TRAJECTORY & !trajectory_complete ->
        P9: (s'=0) & (time_step'=time_step+1) +
        P2: (s'=1) & (time_step'=time_step+1) +
        (1 - (P2 + P9)): (s'=2) & (time_step'=time_step+1);
    [] s=0 & time_step = MAX_TIME_TRAJECTORY ->
        1.0: (s'=3) & (trajectory_complete'=true);

    // S1 transitions
    [] s=1 & time_step < MAX_TIME_TRAJECTORY & !trajectory_complete ->
        P3: (s'=1) & (time_step'=time_step+1) +
        P4: (s'=4) & (time_step'=time_step+1) +
        (1 - (P3 + P4)): (s'=2) & (time_step'=time_step+1);
    [] s=1 & time_step = MAX_TIME_TRAJECTORY ->
        1.0: (s'=3) & (trajectory_complete'=true);

    // S2: undetectedEscalation
    [] s=2 -> 1.0: (s'=8) & (time_step'=0);

    // S3: dressingComplete
    [] s=3 -> 1.0: (s'=9);

    // S4: mitigation decision
    [] s=4 -> 
        P5: (s'=5) +
        P6: (s'=6) +
        (1 - (P5 + P6)): (s'=8);

    // S5: HRI
    [] s=5 -> 
        P8: (s'=4) +
        (1 - P8): (s'=7);

    // S6: Autonomous mitigation
    [] s=6 & t < MAX_TIME ->
        P7: (s'=7) +
        (1 - P7): (s'=6) & (t'=t+1);
    [] s=6 & t = MAX_TIME ->
        1.0: (s'=8);

    // S7: mitigationSuccess
    [] s=7 -> 1.0: (s'=0) & (time_step'=0);

    // S8: abortTask
    [] s=8 -> 1.0: (s'=9) & (time_step'=0);

    // S9: terminal
    [] s=9 -> 
        p10: (s'=9) +
        (1 - p10): (s'=0);
endmodule

// Rewards
rewards "time"
    true : 1;
endrewards

rewards "cost_s2"
    s=2 : C_S2;
endrewards

rewards "cost_s8"
    s=8 : C_S8;
endrewards

rewards "reward_s7"
    s=7 : R_S7;
endrewards

rewards "reward_s3"
    s=3 : BASE_REWARD_S3;
endrewards
