#include <iostream>
#include <ctime>
#include <cmath>
#include <chrono>
#include <memory>
#include <functional>
#include <iostream>
#include <algorithm>

using namespace std;
using namespace std::placeholders;

double res = 0, _res=0;

 void* add(void *px, void* py){
    //cout << px << " + " << py << endl;
    //cout << ((double*)px) << " + " << ((double*)py) << endl;
    double *a = ((double*)px);
    double *b = ((double*)py);
    //cout << *b << " + " << *a << endl;
    res = (*a+*b);
    //cout << res <<" | &" << &res << endl;
    return &res;
}

 void* _add_(double *px, double* py, double *_res){
   // cout << px << " + " << py << endl;
   // cout << ((double*)px) << " + " << ((double*)py) << endl;
   // double *a = px;
   // double *b = py;
    //cout << *b << " + " << *a << endl;
    *_res = (*px+*py);
   // cout << res <<" | &" << &res << endl;
}

 double* _add(double *px, double* py){
   // cout << px << " + " << py << endl;
   // cout << ((double*)px) << " + " << ((double*)py) << endl;
   // double *a = px;
   // double *b = py;
    //cout << *b << " + " << *a << endl;
    res = (*px+*py);
    return &res;
   // cout << res <<" | &" << &res << endl;
}

void* sub(void *px, void* py){
    //cout << px << " - " << py << endl;
    //cout << ((double*)px) << " - " << ((double*)py) << endl;
    double *a = ((double*)px);
    double *b = ((double*)py);
    //cout << *b << " - " << *a << endl;
    res = (*a-*b);
    //cout << res << " | &" << &res << endl;
    return &res;
}

void* mult(void *px, void* py){
    //cout << px << " * " << py << endl;
    //cout << ((double*)px) << " * " << ((double*)py) << endl;
    double *a = ((double*)px);
    double *b = ((double*)py);
    //cout<< *b << " * " << *a << endl;
    res = (*a* *b);
    //cout<< res << " | &" << &res << endl;
    return &res;
}

void* process(void *px, void *py, void* (*f)(void*, void*) ){
    //cout << (*(double*)px) << " | " << (*(double*)px) << endl;
    void *_res = f(px,py);
    return _res;
}

void* _fun_process(void *px, void *py, std::function<void* (void* , void*)> f ){
    //cout << (*(double*)px) << " | " << (*(double*)px) << endl;
    void *_res = f(px,py);
    return _res;
}

double* _double_fun_process(double *px, double *py, std::function<double* (double* , double*)> f ){
    //cout << (*(double*)px) << " | " << (*(double*)px) << endl;
    double *_res = f(px,py);
    return _res;
}

void* _double_fun_process_(double *px, double *py, double *res, std::function<void* (double* , double*, double*)> f ){
    //cout << (*(double*)px) << " | " << (*(double*)px) << endl;
    f(px,py,res);
}

static double a = 15, b = 10;


void* (*fun_ptr_arr[])(void*, void*) = {add,add};
std::function<void* (void* , void*)> fun_ptr_add = std::bind(&add,_1,_2);
std::function<double* (double* , double*)> _fun_ptr_add = std::bind(&_add,_1,_2);
std::function<void* (double* , double*,double*)> fun_ptr_add_ = std::bind(&_add_,_1,_2, _3);

typedef std::function<void* (void* , void*)> td_fun_ptr_add;
td_fun_ptr_add __td_fun_ptr_add___ = std::bind(&add,_1,_2);

typedef std::function<double* (double* , double*)> td__fun_ptr_add;
td__fun_ptr_add __td__fun_ptr_add__ = std::bind(&_add,_1,_2);

typedef std::function<void* (double* , double*,double*)> td_fun_ptr_add_;
td_fun_ptr_add_ __td_fun_ptr_add____ = std::bind(&_add_,_1,_2, _3);

int main()
{

    int n = 10000000;

    cout << "********************* (*(double*)process(&a,&b,(*fun_ptr_arr[1]))) *********************"<<endl;

    auto start = std::chrono::high_resolution_clock::now();
    for (int i=0; i<n; i++)
        (*(double*)process(&a,&b,(*fun_ptr_arr[1])));
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n" <<endl<<endl;


    cout << "********************* (*(double*)*fun_ptr_arr[1](&a,&b)); *********************"<<endl;

    start = std::chrono::high_resolution_clock::now();
    for (int i=0; i<n; i++)
        (*(double*)fun_ptr_arr[1](&a,&b));
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n" <<endl<<endl;


   cout << "*********************  (*(double*)_fun_process(&a,&b,fun_ptr_add));; *********************"<<endl;

    start = std::chrono::high_resolution_clock::now();
     for (int i=0; i<n; i++)
       (*(double*)_fun_process(&a,&b,fun_ptr_add));
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;


    cout << "*********************         (*(double*)fun_ptr_add(&a,&b));  *********************"<<endl;

    start = std::chrono::high_resolution_clock::now();
     for (int i=0; i<n; i++)
       (*(double*)fun_ptr_add(&a,&b));
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;

    cout << "*********************     <Double>_fun_ptr_add(&a,&b); *********************"<<endl;

    start = std::chrono::high_resolution_clock::now();
     for (int i=0; i<n; i++)
       _fun_ptr_add(&a,&b);
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;

    cout << "*********************       _double_fun_process(&a,&b,_fun_ptr_add); *********************"<<endl;

     start = std::chrono::high_resolution_clock::now();
     for (int i=0; i<n; i++)
              _double_fun_process(&a,&b,_fun_ptr_add);
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;

     cout << "*********************      [&](double x, double y)->double{return x+y; }; *********************"<<endl;

     start = std::chrono::high_resolution_clock::now();
     for (int i=0; i<n; i++)
              [&](double, double )->double{return a+b; };
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;

    cout << "*********************         _add_(&a,&b,&_res);  *********************"<<endl;

    start = std::chrono::high_resolution_clock::now();
    for (int i=0; i<n; i++)
               _add_(&a,&b,&res);
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;

    cout << "*********************         fun_ptr_add_(&a,&b,&res);  *********************"<<endl;

    start = std::chrono::high_resolution_clock::now();
    for (int i=0; i<n; i++)
               fun_ptr_add_(&a,&b,&res);
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;

    cout << "*********************     _double_fun_process_(&a,&b,&res,fun_ptr_add_); *********************"<<endl;

    start = std::chrono::high_resolution_clock::now();
    for (int i=0; i<n; i++)
               _double_fun_process_(&a,&b,&res,fun_ptr_add_);
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;


    cout << "*********************   __td_fun_ptr_add___(&a,&b);   *********************"<<endl;

    start = std::chrono::high_resolution_clock::now();
    for (int i=0; i<n; i++)
               __td_fun_ptr_add___(&a,&b);
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;


    cout << "*********************   __td__fun_ptr_add__(&a,&b);   *********************"<<endl;

    start = std::chrono::high_resolution_clock::now();
    for (int i=0; i<n; i++)
               __td__fun_ptr_add__(&a,&b);
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;


    cout << "*********************       __td_fun_ptr_add____(&a,&b,&res);   *********************"<<endl;

    start = std::chrono::high_resolution_clock::now();
    for (int i=0; i<n; i++)
               __td_fun_ptr_add____(&a,&b,&res);
    std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now()-start).count() << " ns \n"<<endl<<endl;

    return 0;
}




