{ pkgs }: {
    channel = "stable-24.05";
    packages = [
        pkgs.nodejs_20
        pkgs.pnpm
        pkgs.php82Packages.cyclonedx-php-composer
        pkgs.php82
        pkgs.ocamlPackages.sail
    ];
    idx.extensions = [
        "svelte.svelte-vscode"
        "vue.volar"
    ];
    idx.previews = {
        previews = {
            web = {
                command = [
                    "npm"
                    "run"
                    "dev"
                    "--"
                    "--port"
                    "$PORT"
                    "--host"
                    "0.0.0.0"
                ];
                manager = "web";
            };
        };
    };
}
