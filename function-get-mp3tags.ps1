<#
.Synopsis
   Short description
.DESCRIPTION
   This code is based on Shaun Cassells Get-Mp3FilesLessThan which I found at:
   http://myitforum.com/myitforumwp/2012/07/24/music-library-cleaning-with-powershell-identifying-old-mp3-files-with-low-bitrates/
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-RawExtendedFileProperties
            
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "$pwd" ) 


  Process
  {

    $shellObject = New-Object -ComObject Shell.Application
  
  
    $Files = Get-ChildItem $folder -recurse 
  
    foreach( $file in $Files ) 
    {
  
      write-verbose "Get-RawExtendedFileProperties: Processing file $file"
  
      $directoryObject = $shellObject.NameSpace( $file.Directory.FullName )
  
      $fileObject = $directoryObject.ParseName( $file.Name )
      $RawFileProperties = New-Object PSObject
  
      for( $index = 0 ; $index -lt 1000; ++$index ) 
      {
  
        $name = $directoryObject.GetDetailsOf( $directoryObject.Items, $index )
  
        $value = $directoryObject.GetDetailsOf( $fileObject, $index )
  
        if ($name -ne "")
        {
          Add-Member -InputObject $RawFileProperties -MemberType NoteProperty -Name $name.replace(" ","") -value "$value"
          # write-debug "Adding Member -Name $name -value $value"
        }
      }

    return $RawFileProperties
  

    }
  
  }
  End
  {
  }
}
 

<#
.SYNOPSIS
   Short description

.DESCRIPTION

.EXAMPLE
   Get-CookedExtendedProperties -folder "D:\music\Desm*" -verbose

.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-CookedExtendedFileProperties
            
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "$pwd" ) 

  Begin
  {
  }
  

  Process
  {

    # Todo: Need to remember/work out how to pass switches betwwen functions i.e. -verbose and -recurse

    $Expression = "`$CookedObject = [PSCustomObject]@{ "

    $Csv = import-csv ExtendedFileProperties.dat | ? Usedfor -like "*Mp3*"
    foreach ($r in $Csv ) 
    { 
      $Expression = $Expression + $r.CookedName + " = `$RawExtendedFileProperties.`"" + $r.RawName + "`"" + "`n"
      write-debug "`$Expression: $Expression"
    }

    $Expression = $Expression.substring(0, $Expression.length - 1 )
    $Expression = $Expression + "}"


    $Files = Get-ChildItem $folder -recurse 
  
    foreach( $file in $Files ) 
    {
  
      write-verbose "$MyInvocation.MyCommand.Name Processing file $file"
      $RawExtendedFileProperties = Get-RawExtendedFileProperties -folder $file
  
      write-debug "`$Expression: $Expression"
      invoke-expression $Expression
<#
      $CookedObject = [PSCustomObject]@{ 
        SequenceNumber = $RawExtendedFileProperties."#"
        ThirtyFiveMmFocalLength  = $RawExtendedFileProperties."35mmFocalLength"
        AccountName  = $RawExtendedFileProperties.AccountName  
        Album = $RawExtendedFileProperties.Album  
        AlbumArtist = $RawExtendedFileProperties.AlbumArtist  
        AlbumID = $RawExtendedFileProperties.AlbumID  
        Anniversary = $RawExtendedFileProperties.Anniversary
        AssistantsName = $RawExtendedFileProperties."Assistant'sName"
        AssistantsPhone = $RawExtendedFileProperties."Assistant'sPhone"
        Attachments = $RawExtendedFileProperties.Attachments
        Attributes = $RawExtendedFileProperties.Attributes
        Authors = $RawExtendedFileProperties.Authors
        Autosummary = $RawExtendedFileProperties.Autosummary
        Availability = $RawExtendedFileProperties.Availability
        Bcc = $RawExtendedFileProperties.Bcc
        BccAddresses = $RawExtendedFileProperties.BccAddresses
        BeatsPerMinute = $RawExtendedFileProperties."Beats-per-minute"
        BillingInformation = $RawExtendedFileProperties.BillingInformation
        Birthday = $RawExtendedFileProperties.Birthday
        BitDepth = $RawExtendedFileProperties.BitDepth
        BitRate = $RawExtendedFileProperties.BitRate
        BroadcastDate = $RawExtendedFileProperties.BroadcastDate
        BusinessAddress = $RawExtendedFileProperties.BusinessAddress
        BusinessCity = $RawExtendedFileProperties.BusinessCity
        BusinessCountryOrRegion = $RawExtendedFileProperties."BusinessCountry/Region"
        BusinessCountyOrRegion = $RawExtendedFileProperties."BusinessCounty/Region"
        BusinessFax = $RawExtendedFileProperties.BusinessFax
        BusinessHomepage = $RawExtendedFileProperties.BusinessHomepage
        BusinessPOBox = $RawExtendedFileProperties."BusinessP.O.Box"
        BusinessPhone = $RawExtendedFileProperties.BusinessPhone
        BusinessPostcode = $RawExtendedFileProperties.BusinessPostcode
        BusinessStreet = $RawExtendedFileProperties.BusinessStreet
        ByLocation = $RawExtendedFileProperties.ByLocation
        CallBackNumber = $RawExtendedFileProperties."Call-BackNumber"
        CameraMaker = $RawExtendedFileProperties.CameraMaker
        CameraModel = $RawExtendedFileProperties.CameraModel
        CarPhone = $RawExtendedFileProperties.CarPhone
        Categories = $RawExtendedFileProperties.Categories
        Cc = $RawExtendedFileProperties.Cc
        CcAddresses = $RawExtendedFileProperties.CcAddresses
        ChannelNumber = $RawExtendedFileProperties.ChannelNumber
        Children = $RawExtendedFileProperties.Children
        City = $RawExtendedFileProperties.City
        Classification = $RawExtendedFileProperties.Classification
        ClientID = $RawExtendedFileProperties.ClientID
        ClosedCaptioning = $RawExtendedFileProperties.ClosedCaptioning
        Colour = $RawExtendedFileProperties.Colour
        Comments = $RawExtendedFileProperties.Comments
        Company = $RawExtendedFileProperties.Company
        CompanyMainphone = $RawExtendedFileProperties.CompanyMainphone
        Complete = $RawExtendedFileProperties.Complete
        Composers = $RawExtendedFileProperties.Composers
        Computer = $RawExtendedFileProperties.Computer
        Conductors = $RawExtendedFileProperties.Conductors
        Connected = $RawExtendedFileProperties.Connected
        ContactNames = $RawExtendedFileProperties.ContactNames
        ContentCreated = $RawExtendedFileProperties.ContentCreated
        ContentStatus = $RawExtendedFileProperties.ContentStatus
        ContentType = $RawExtendedFileProperties.ContentType
        ContributingArtists = $RawExtendedFileProperties.ContributingArtists
        Contributors = $RawExtendedFileProperties.Contributors
        ConversationID = $RawExtendedFileProperties.ConversationID
        Copyright = $RawExtendedFileProperties.Copyright
        CountryOrRegion = $RawExtendedFileProperties."Country/Region"
        CountyOrRegion = $RawExtendedFileProperties."County/Region"
        Creators = $RawExtendedFileProperties.Creators
        DataRate = $RawExtendedFileProperties.DataRate
        Date = $RawExtendedFileProperties.Date
        DateAccessed = $RawExtendedFileProperties.DateAccessed
        DateAcquired = $RawExtendedFileProperties.DateAcquired
        DateArchived = $RawExtendedFileProperties.DateArchived
        DateCompleted = $RawExtendedFileProperties.DateCompleted
        DateCreated = $RawExtendedFileProperties.DateCreated
        DateLastSaved = $RawExtendedFileProperties.DateLastSaved
        DateModified = $RawExtendedFileProperties.DateModified
        DateReceived = $RawExtendedFileProperties.DateReceived
        DateReleased = $RawExtendedFileProperties.DateReleased
        DateSent = $RawExtendedFileProperties.DateSent
        DateTaken = $RawExtendedFileProperties.DateTaken
        DateVisited = $RawExtendedFileProperties.DateVisited
        Department = $RawExtendedFileProperties.Department
        Description = $RawExtendedFileProperties.Description
        Devicecategory = $RawExtendedFileProperties.Devicecategory
        Dimensions = $RawExtendedFileProperties.Dimensions
        Directors = $RawExtendedFileProperties.Directors
        DiscoveryMethod = $RawExtendedFileProperties.DiscoveryMethod
        Division = $RawExtendedFileProperties.Division
        DocumentID = $RawExtendedFileProperties.DocumentID
        DueDate = $RawExtendedFileProperties.DueDate
        Duration = $RawExtendedFileProperties.Duration
        Email2 = $RawExtendedFileProperties.Email2
        Email3 = $RawExtendedFileProperties.Email3
        EmailAddress = $RawExtendedFileProperties.EmailAddress
        EmailDisplayname = $RawExtendedFileProperties.EmailDisplayname
        EmailList = $RawExtendedFileProperties.EmailList
        EncodedBy = $RawExtendedFileProperties.EncodedBy
        EncryptedTo = $RawExtendedFileProperties.EncryptedTo
        EncryptionStatus = $RawExtendedFileProperties.EncryptionStatus
        EndDate = $RawExtendedFileProperties.EndDate
        EntryType = $RawExtendedFileProperties.EntryType
        EpisodeName = $RawExtendedFileProperties.EpisodeName
        EpisodeNumber = $RawExtendedFileProperties.EpisodeNumber
        Event = $RawExtendedFileProperties.Event
        ExifVersion = $RawExtendedFileProperties.ExifVersion
        ExposureBias = $RawExtendedFileProperties.ExposureBias
        ExposureProgram = $RawExtendedFileProperties.ExposureProgram
        ExposureTime = $RawExtendedFileProperties.ExposureTime
        FStop = $RawExtendedFileProperties."F-Stop"
        FileAs = $RawExtendedFileProperties.FileAs
        FileCount = $RawExtendedFileProperties.FileCount
        FileDescription = $RawExtendedFileProperties.FileDescription
        FileExtension = $RawExtendedFileProperties.FileExtension
        Filename = $RawExtendedFileProperties.Filename
        FileVersion = $RawExtendedFileProperties.FileVersion
        FirstName = $RawExtendedFileProperties.FirstName
        FlagColour = $RawExtendedFileProperties.FlagColour
        FlagStatus = $RawExtendedFileProperties.FlagStatus
        FlashMode = $RawExtendedFileProperties.FlashMode
        FocalLength = $RawExtendedFileProperties.FocalLength
        Folder = $RawExtendedFileProperties.Folder
        FolderName = $RawExtendedFileProperties.FolderName
        FolderPath = $RawExtendedFileProperties.FolderPath
        FrameHeight = $RawExtendedFileProperties.FrameHeight
        FrameRate = $RawExtendedFileProperties.FrameRate
        FrameWidth = $RawExtendedFileProperties.FrameWidth
        FreeOrBusyStatus = $RawExtendedFileProperties."Free/BusyStatus"
        FriendlyName = $RawExtendedFileProperties.FriendlyName
        From = $RawExtendedFileProperties.From
        FromAddresses = $RawExtendedFileProperties.FromAddresses
        FullName = $RawExtendedFileProperties.FullName
        FullStop = $RawExtendedFileProperties.FullStop
        Gender = $RawExtendedFileProperties.Gender
        Genre = $RawExtendedFileProperties.Genre
        GivenName = $RawExtendedFileProperties.GivenName
        Group = $RawExtendedFileProperties.Group
        HasAttachments = $RawExtendedFileProperties.HasAttachments
        HasFlag = $RawExtendedFileProperties.HasFlag
        Height = $RawExtendedFileProperties.Height
        Hobbies = $RawExtendedFileProperties.Hobbies
        HomeAddress = $RawExtendedFileProperties.HomeAddress
        HomeCity = $RawExtendedFileProperties.HomeCity
        HomeCountryOrRegion = $RawExtendedFileProperties."HomeCountry/region"
        HomeCountyOrRegion = $RawExtendedFileProperties."HomeCounty/region"
        HomeFax = $RawExtendedFileProperties.HomeFax
        HomePoBox = $RawExtendedFileProperties."HomeP.o.Box"
        HomePhone = $RawExtendedFileProperties.HomePhone
        HomePostcode = $RawExtendedFileProperties.HomePostcode
        HomeStreet = $RawExtendedFileProperties.HomeStreet
        HorizontalResolution = $RawExtendedFileProperties.HorizontalResolution
        ImAddresses = $RawExtendedFileProperties.ImAddresses
        Importance = $RawExtendedFileProperties.Importance
        Incomplete = $RawExtendedFileProperties.Incomplete
        InitialKey = $RawExtendedFileProperties.InitialKey
        Initials = $RawExtendedFileProperties.Initials
        IsAttachment = $RawExtendedFileProperties.IsAttachment
        IsCompleted = $RawExtendedFileProperties.IsCompleted
        IsDeleted = $RawExtendedFileProperties.IsDeleted
        IsOnline = $RawExtendedFileProperties.IsOnline
        IsoSpeed = $RawExtendedFileProperties.IsoSpeed
        IsRecurring = $RawExtendedFileProperties.IsRecurring
        ItemType = $RawExtendedFileProperties.ItemType
        JobTitle = $RawExtendedFileProperties.JobTitle
        Kind = $RawExtendedFileProperties.Kind
        Label = $RawExtendedFileProperties.Label
        Language = $RawExtendedFileProperties.Language
        LastPrinted = $RawExtendedFileProperties.LastPrinted
        LegalTrademarks = $RawExtendedFileProperties.LegalTrademarks
        Length = $RawExtendedFileProperties.Length
        LensMaker = $RawExtendedFileProperties.LensMaker
        LensModel = $RawExtendedFileProperties.LensModel
        LightSource = $RawExtendedFileProperties.LightSource
        LinkStatus = $RawExtendedFileProperties.LinkStatus
        LinkTarget = $RawExtendedFileProperties.LinkTarget
        LocalComputer = $RawExtendedFileProperties.LocalComputer
        Location = $RawExtendedFileProperties.Location
        Manufacturer = $RawExtendedFileProperties.Manufacturer
        MaxAperture = $RawExtendedFileProperties.MaxAperture
        MediaCreated = $RawExtendedFileProperties.MediaCreated
        MeetingStatus = $RawExtendedFileProperties.MeetingStatus
        MeteringMode = $RawExtendedFileProperties.MeteringMode
        MiddleName = $RawExtendedFileProperties.MiddleName
        Mileage = $RawExtendedFileProperties.Mileage
        MobilePhone = $RawExtendedFileProperties.MobilePhone
        Model = $RawExtendedFileProperties.Model
        Mood = $RawExtendedFileProperties.Mood
        Name = $RawExtendedFileProperties.Name
        Nickname = $RawExtendedFileProperties.Nickname
        OfficeLocation = $RawExtendedFileProperties.OfficeLocation
        OfflineStatus = $RawExtendedFileProperties.OfflineStatus
        OptionalAttendeeAddresses = $RawExtendedFileProperties.OptionalAttendeeAddresses
        OptionalAttendees = $RawExtendedFileProperties.OptionalAttendees
        OrganiserAddress = $RawExtendedFileProperties.OrganiserAddress
        OrganiserName = $RawExtendedFileProperties.OrganiserName
        Orientation = $RawExtendedFileProperties.Orientation
        OtherAddress = $RawExtendedFileProperties.OtherAddress
        OtherCity = $RawExtendedFileProperties.OtherCity
        OtherCountryOrRegion = $RawExtendedFileProperties."OtherCountry/Region"
        OtherCountyOrRegion = $RawExtendedFileProperties."OtherCounty/Region"
        OtherPoBox = $RawExtendedFileProperties."OtherP.o.Box"
        OtherPostCode = $RawExtendedFileProperties.OtherPostCode
        OtherStreet = $RawExtendedFileProperties.OtherStreet
        Owner = $RawExtendedFileProperties.Owner
        PoBox = $RawExtendedFileProperties."P.O.box"
        Pager = $RawExtendedFileProperties.Pager
        Pages = $RawExtendedFileProperties.Pages
        Paired = $RawExtendedFileProperties.Paired
        ParentalRating = $RawExtendedFileProperties.ParentalRating
        ParentalRatingReason = $RawExtendedFileProperties.ParentalRatingReason
        Participants = $RawExtendedFileProperties.Participants
        PartOfACompilation = $RawExtendedFileProperties.PartOfACompilation
        PartOfSet = $RawExtendedFileProperties.PartOfSet
        Path = $RawExtendedFileProperties.Path
        People = $RawExtendedFileProperties.People
        PerceivedType = $RawExtendedFileProperties.PerceivedType
        PersonalTitle = $RawExtendedFileProperties.PersonalTitle
        PostalAddress = $RawExtendedFileProperties.PostalAddress
        Postcode = $RawExtendedFileProperties.Postcode
        PrimaryEmail = $RawExtendedFileProperties.PrimaryEmail
        PrimaryPhone = $RawExtendedFileProperties.PrimaryPhone
        Priority = $RawExtendedFileProperties.Priority
        Producers = $RawExtendedFileProperties.Producers
        ProductName = $RawExtendedFileProperties.ProductName
        ProductVersion = $RawExtendedFileProperties.ProductVersion
        Profession = $RawExtendedFileProperties.Profession
        ProgramDescription = $RawExtendedFileProperties.ProgramDescription
        ProgramMode = $RawExtendedFileProperties.ProgramMode
        ProgramName = $RawExtendedFileProperties.ProgramName
        Project = $RawExtendedFileProperties.Project
        Protected = $RawExtendedFileProperties.Protected
        Publisher = $RawExtendedFileProperties.Publisher
        Rating = $RawExtendedFileProperties.Rating
        ReadStatus = $RawExtendedFileProperties.ReadStatus
        RecordingTime = $RawExtendedFileProperties.RecordingTime
        ReminderTime = $RawExtendedFileProperties.ReminderTime
        RequiredAttendeeAddresses = $RawExtendedFileProperties.RequiredAttendeeAddresses
        RequiredAttendees = $RawExtendedFileProperties.RequiredAttendees
        Rerun = $RawExtendedFileProperties.Rerun
        Resources = $RawExtendedFileProperties.Resources
        SAP = $RawExtendedFileProperties.SAP
        Saturation = $RawExtendedFileProperties.Saturation
        SearchRanking = $RawExtendedFileProperties.SearchRanking
        SeasonNumber = $RawExtendedFileProperties.SeasonNumber
        SenderAddress = $RawExtendedFileProperties.SenderAddress
        SenderName = $RawExtendedFileProperties.SenderName
        Sensitivity = $RawExtendedFileProperties.Sensitivity
        Shared = $RawExtendedFileProperties.Shared
        SharedWith = $RawExtendedFileProperties.SharedWith
        Sharing = $RawExtendedFileProperties.Sharing
        SharingStatus = $RawExtendedFileProperties.SharingStatus
        SharingType = $RawExtendedFileProperties.SharingType
        Size = $RawExtendedFileProperties.Size
        Slides = $RawExtendedFileProperties.Slides
        Snippets = $RawExtendedFileProperties.Snippets
        SortAlbum = $RawExtendedFileProperties.SortAlbum
        SortAlbumArtist = $RawExtendedFileProperties.SortAlbumArtist
        SortComposer = $RawExtendedFileProperties.SortComposer
        SortContributingArtists = $RawExtendedFileProperties.SortContributingArtists
        SortTitle = $RawExtendedFileProperties.SortTitle
        Source = $RawExtendedFileProperties.Source
        SpaceFree = $RawExtendedFileProperties.SpaceFree
        SpaceUsed = $RawExtendedFileProperties.SpaceUsed
        SpouseOrPartner = $RawExtendedFileProperties."Spouse/Partner"
        StartDate = $RawExtendedFileProperties.StartDate
        StationCallSign = $RawExtendedFileProperties.StationCallSign
        StationName = $RawExtendedFileProperties.StationName
        Status = $RawExtendedFileProperties.Status
        Store = $RawExtendedFileProperties.Store
        Street = $RawExtendedFileProperties.Street
        Subject = $RawExtendedFileProperties.Subject
        SubjectDistance = $RawExtendedFileProperties.SubjectDistance
        Subtitle = $RawExtendedFileProperties.Subtitle
        Suffix = $RawExtendedFileProperties.Suffix
        Summary = $RawExtendedFileProperties.Summary
        SupportLink = $RawExtendedFileProperties.SupportLink
        Surname = $RawExtendedFileProperties.Surname
        Tags = $RawExtendedFileProperties.Tags
        TaskOwner = $RawExtendedFileProperties.TaskOwner
        TaskStatus = $RawExtendedFileProperties.TaskStatus
        Telex = $RawExtendedFileProperties.Telex
        Title = $RawExtendedFileProperties.Title
        To = $RawExtendedFileProperties.To
        ToAddresses = $RawExtendedFileProperties.ToAddresses
        TodoTitle = $RawExtendedFileProperties.TodoTitle
        TotalBitRate = $RawExtendedFileProperties.TotalBitRate
        TotalEditingTime = $RawExtendedFileProperties.TotalEditingTime
        TotalFileSize = $RawExtendedFileProperties.TotalFileSize
        TotalSize = $RawExtendedFileProperties.TotalSize
        TTYOrTTDphone = $RawExtendedFileProperties."TTY/TTDphone"
        Type = $RawExtendedFileProperties.Type
        URL = $RawExtendedFileProperties.URL
        UserWebURL = $RawExtendedFileProperties.UserWebURL
        VerticalResolution = $RawExtendedFileProperties.VerticalResolution
        Videocompression = $RawExtendedFileProperties.Videocompression
        VideoOrientation = $RawExtendedFileProperties.VideoOrientation
        WebPage = $RawExtendedFileProperties.WebPage
        WhiteBalance = $RawExtendedFileProperties.WhiteBalance
        Width = $RawExtendedFileProperties.Width
        WordCount = $RawExtendedFileProperties.WordCount
        Writers = $RawExtendedFileProperties.Writers
        Year = $RawExtendedFileProperties.Year
      
      } #EndCustomObject
#>
      $CookedObject
      
    } #EndForeach
  
  
  }
  End
  {
  }
}
 

 

 

# $X = Get-ExtendedFileProperties -folder "D:\music\Desm*" -verbose
# $X | select Size, Album


<#
.Synopsis
   Get extended properties depending on filetype
.DESCRIPTION
.EXAMPLE
   Get-SelectedExtendedFileProperties -folder "D:\music\*Take*"
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-SelectedExtendedFileProperties
            
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "$pwd",
         [string]$filetype = "default") 


  Process
  {

    $Csv = import-csv ExtendedFileProperties.dat

    $Files = Get-ChildItem $folder -recurse 
  
    foreach( $file in $Files ) 
    {
  
      write-verbose "$MyInvocation.MyCommand.Name: Processing file $file"

      [string]$Expression = "Get-CookedExtendedFileProperties -folder `"$file`" | "
 
      $Expression = $Expression + "select "

      foreach ($Prop in $($Csv | ? Usedfor -like "*Mp3*" )) 
      {
        write-debug "$`Prop.CookedName:  $Prop.CookedName"
        $Expression = $Expression + $Prop.CookedName + ", "
      }

      $Expression = $Expression.substring(0, $Expression.length - 2 )

      write-debug "`$Expression $Expression"

      invoke-expression $Expression

    }

  }
      

<#
$Csv = import-csv ExtendedFileProperties.dat
$Csv | gm
$Csv | ? USedfor -like "*mp3*" | select PowershellName
$Csv | ? USedfor -like "*mp3*" | out-string
$Csv | ? USedfor -like "*mp3*" | format-table @{Expression = "PowershellName" + ","}
$Csv | ? USedfor -like "*mp3*" | format-table @{Expression = $_.PowershellName + ","}
$Csv | ? USedfor -like "*mp3*" | format-table @{Expression = {$_.PowershellName + ","}}
$String = $Csv | ? USedfor -like "*mp3*" | format-table @{Expression = {$_.PowershellName + ","}}
$String
#foreach ($Prop in $($Csv | ? Usedfor -like "*Mp3*" )) {$X = $X + $Prop.PowershellName + ","}
[string]$X="select "
foreach ($Prop in $($Csv | ? Usedfor -like "*Mp3*" )) {$X = $X + $Prop.PowershellName + ","}
$X
$X = $X.substring(0, $X.length)
$X
$X = $X.substring(0, $X.length -1 )
$X
#>


  

  
  End
  {
  }
}
 


# vim: set softtabstop=2 shiftwidth=2 expandtab
