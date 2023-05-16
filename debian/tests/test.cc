// https://oneapi-src.github.io/oneTBB/main/tbb_userguide/Migration_Guide/Task_Scheduler_Init.html
#include <cstdint>
#include <oneapi/tbb/info.h>
#include <oneapi/tbb/parallel_for.h>
#include <oneapi/tbb/task_arena.h>
#include <iostream>
#include <cassert>
int main()
{
    int num_threads = oneapi::tbb::info::default_concurrency();
    std::cout << num_threads << std::endl;
    return 0;
}
