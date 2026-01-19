# Fetch latest changes
git fetch

# Check if local is behind remote
$behind = git rev-list --count HEAD..origin/main

if ($behind -gt 0) {
    Write-Host "New commits found. Updating..."

    git pull

    docker build -t homepage .

    docker stop homepage 2>$null
    docker rm homepage 2>$null

    docker run -d --name homepage --restart unless-stopped -p 15990:80 homepage

    Write-Host "Deployment complete."
}
else {
    Write-Host "No new commits."
}
