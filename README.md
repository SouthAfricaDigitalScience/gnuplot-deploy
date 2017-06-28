[![Build Status](https://ci.sagrid.ac.za/buildStatus/icon?job=gnuplot-deploy)](https://ci.sagrid.ac.za/job/gnuplot-deploy) [![DOI](https://zenodo.org/badge/49285358.svg)](https://zenodo.org/badge/latestdoi/49285358)


# gnuplot-deploy

Build, test and deploy scripts for [gnuplot](http://www.gnuplot.info/) for CODE-RADE.


# Dependencies

This project depends on

  * [lua](https://ci.sagrid.ac.za/job/lua-deploy)
  * [zlib](https://ci.sagrid.ac.za/job/zlib-deploy)

# Versions

We build the following versions :

  * 5.0.3
  * 4.6.7

# Configuration

The builds are configured out-of-source with cmake :

```
LDFLAGS="-L${READLINE_DIR}/lib -L${NCURSES_DIR} -lncurses" ../configure --prefix=${SOFT_DIR} \
--with-readline=gnu \
--with-qt=no
make -j 2
```

# Citing

Cite as :
Bruce Becker. (2017, June 28). SouthAfricaDigitalScience/gnuplot-deploy: CODE-RADE Foundation Release 3 - gnuplot. Zenodo. http://doi.org/10.5281/zenodo.820469 
