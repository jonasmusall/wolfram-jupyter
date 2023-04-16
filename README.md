# wolfram-jupyter

## Setup

First, obtain a license file by running `scripts/activate.sh`.

> 💡 If you already got a `mathpass` file, you can just copy it to the `Licensing` subfolder. However, `mathpass` files from a direct installation of `wolframscript` (not in a Docker container) will not work.

```text
$ ./scripts/activate.sh
Please enter "Quit" after logging in using your Wolfram ID and password.

The Wolfram Engine requires one-time activation on this computer.

Visit https://wolfram.com/engine/free-license to get your free license.

Wolfram ID: yourwolframid@example.com
Password:
Wolfram Engine activated. See https://www.wolfram.com/wolframscript/ for more information.
Wolfram Language 13.2.0 Engine for Linux x86 (64-bit)
Copyright 1988-2022 Wolfram Research, Inc.

In[1]:= Quit
```

Then, build the Docker image by running `scripts/build.sh`.

```text
$ ./scripts/build.sh
[+] Building 32.9s (21/21) FINISHED
 => [internal] load build definition from Dockerfile                            0.0s
 => => transferring dockerfile: 1.66kB                                          0.0s
 => [internal] load .dockerignore                                               0.0s
 => => transferring context: 2B                                                 0.0s
[...]
 => => naming to docker.io/library/wolfram-jupyter                              0.0s
```

## Running

Choose a directory you want to work on your notebooks in and supply the path as an argument to `scripts/run.sh` (this script is generated during the build step).

```text
$ ./scripts/run.sh ~/wolfram-jupyter-notebooks
[I 15:57:53.959 NotebookApp] Writing notebook server cookie secret to /home/you/.local/share/jupyter/runtime/notebook_cookie_secret
[I 15:57:54.108 NotebookApp] Serving notebooks from local directory: /mnt/jupyter
[I 15:57:54.108 NotebookApp] Jupyter Notebook 6.4.10 is running at:
[I 15:57:54.108 NotebookApp] http://2838bb30a2d6:8888/?token=bed22856cdc79ab5b64aa2e9e4eea30b53f5efbbb6347fd0
[I 15:57:54.108 NotebookApp]  or http://127.0.0.1:8888/?token=bed22856cdc79ab5b64aa2e9e4eea30b53f5efbbb6347fd0
[I 15:57:54.108 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 15:57:54.111 NotebookApp] 
    
    To access the notebook, open this file in a browser:
        file:///home/you/.local/share/jupyter/runtime/nbserver-7-open.html
    Or copy and paste one of these URLs:
        http://2838bb30a2d6:8888/?token=bed22856cdc79ab5b64aa2e9e4eea30b53f5efbbb6347fd0
     or http://127.0.0.1:8888/?token=bed22856cdc79ab5b64aa2e9e4eea30b53f5efbbb6347fd0
```

Note that the file URL and the first web URL output by Jupyter will not work, because they are internal to the Docker container.

> 💡 The `mathpass` file has to be mounted and can not be permanently integrated into the Docker image during the build step, because it has an expiration date and the Wolfram Engine will automatically renew it when it is close to expiring.
