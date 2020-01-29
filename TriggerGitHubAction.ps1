<#
    Triggering Github Actions from a webhook call
#>

#region variables
$GithubToken = $env:githubtoken # Personal Access Token stored as environment variable
$GithubUserName = 'stefanstranger'
$GithubRepo = 'githubactions'
#endregion

$uri = ('https://api.github.com/repos/{0}/{1}/dispatches' -f $GithubUserName, $GithubRepo)

#region web request call
$Body = @{
    'event_type' = 'script' #used in the if condition of the Github Action
} | ConvertTo-Json


$params = @{
    ContentType = 'application/json'
    Headers     = @{
        'authorization' = "token $($GithubToken)"
        'accept'        = 'application/vnd.github.everest-preview+json'
    }
    Method      = 'Post'
    URI         = $Uri
    Body        = $Body
}
  
Invoke-RestMethod @params -verbose
#endregion