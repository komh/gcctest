// C++11 std::thread support test

#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <chrono>

std::mutex g_mtx;
std::condition_variable g_cond;

int g_quit = 0;

void func()
{
    {
        std::lock_guard<std::mutex> guard(g_mtx);

        std::cout << __func__ << ": std::this_thread::get_id() = "
                  << std::this_thread::get_id() << "\n";
    }

    {
        std::unique_lock<std::mutex> lock(g_mtx);
        while (g_quit == 0) {
            std::cout << __func__ << ": id "
                      << std::this_thread::get_id()
                      << "Waiting...\n";
            g_cond.wait(lock);
        }
    }

    {
        std::lock_guard<std::mutex> guard(g_mtx);

        std::cout << __func__ << ": id "
                  << std::this_thread::get_id()
                  << ": Bye!\n";
    }

    g_cond.notify_one();
}

int main()
{
    std::thread th1( func );
    std::thread th2( func );

    {
        std::lock_guard<std::mutex> guard(g_mtx);

        std::cout << "g_mtx.try_lock() = " << g_mtx.try_lock() << "\n";

        std::cout << "std::this_thread::get_id() = "
                  << std::this_thread::get_id() << "\n";
    }

    g_quit = 1;
    g_cond.notify_all();

    {
        std::unique_lock<std::mutex> lock(g_mtx);
        g_cond.wait(lock);
    }

    std::cout << "th1.joinable() = " << th1.joinable() << "\n";

    std::cout << "th1.get_id() = " << th1.get_id() << "\n";

    std::cout << "th1.join():\n";
    th1.join();

    std::cout << "th1.get_id() = " << th1.get_id() << "\n";

    std::cout << "th1.joinable() = " << th1.joinable() << "\n";

    std::chrono::system_clock::time_point t1 = std::chrono::system_clock::now();
    {
        std::unique_lock<std::mutex> lock(g_mtx);
        g_cond.wait_until(lock, t1 + std::chrono::milliseconds(100));
    }
    std::chrono::system_clock::time_point t2 = std::chrono::system_clock::now();

    std::cout << "duration = "
              << std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count()
              << "us\n";

    std::cout << "Bye\n";

    th2.join();

    return 0;
}
