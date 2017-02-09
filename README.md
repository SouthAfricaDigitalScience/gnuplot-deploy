[![Build Status](https://ci.sagrid.ac.za/buildStatus/icon?job=gnuplot-deploy)](https://ci.sagrid.ac.za/job/gnuplot-deploy)

# gnuplot-deploy

Build, test and deploy scripts for [gnuplot](http://www.gnuplot.info/) for CODE-RADE.


# Dependencies

This project depends on

  * [lua](https://ci.sagrid.ac.za/job/lua-deploy)
  * [readline](https://ci.sagrid.ac.za/job/readline-deploy)
  * [zlib](https://ci.sagrid.ac.za/job/zlib-deploy)
  * [ncurses](https://ci.sagrid.ac.za/job/ncurses-deploy)

# Versions

We build the following versions :

  * 5.0.3
  * 4.6.7

# Configuration

The builds are configured out-of-source with cmake :

```
LDFLAGS="-L${READLINE_DIR}/lib -L${NCURSES_DIR} -lncurses" ../configure --prefix=${SOFT_DIR} \
--with-readline=${READLINE_DIR} \
--with-qt=no
make -j 2
```

# Citing
