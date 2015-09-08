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
function Get-ExtendedFileProperties
            
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "$pwd" ) 

  Begin
  {
    $CurrentlyKnownTags =
      "Name",
      "Size",
      "Item type",
      "Date modified",
      "Date created",
      "Date accessed",
      "Attributes",
      "Availability",
      "Perceived type",
      "Owner",
      "Kind",
      "Contributing artists",
      "Album",
      "Year",
      "Genre",
      "Rating",
      "Authors",
      "Title",
      "Comments",
      "#",
      "Length",
      "Bit rate",
      "Protected",
      "Total size",
      "Computer",
      "File extension",
      "Filename",
      "Space free",
      "Shared",
      "Folder name",
      "Folder path",
      "Folder",
      "Path",
      "Type",
      "Link status",
      "Space used",
      "Sharing status"

    # write-verbose "$CurrentlyKnownTags $CurrentlyKnownTags"
  }
  

  Process
  {

    $shellObject = New-Object -ComObject Shell.Application
  
  
    $Files = Get-ChildItem $folder -recurse 
  
    foreach( $file in $Files ) 
    {
  
      write-verbose "Processing file $file"
  
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
          write-debug "Adding Member -Name $name -value $value"

          #
          # if not in array
          # then
          #   write to errorlog file
          #

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
   Get-Mp3Properties -folder "D:\music\Desm*" -verbose

.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-Mp3Properties
            
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
  
  
    $Files = Get-ChildItem $folder -recurse 
  
    foreach( $file in $Files ) 
    {
  
      write-verbose "Processing file $file"
      $ExtendedFileProperties = Get-ExtendedFileProperties -folder $file
  

<#
$obj = [PSCustomObject]@{
Property1 = 'one'
Property2 = 'two'
Property3 = 'three'
}
$obj
#>

# "File.AccountName"
# "$File.Album"
# $RawObject = [PSCustomObject]@{ # SequenceNumber = "$File.`#"

$RawObject = [PSCustomObject]@{ 
SequenceNumber = $ExtendedFileProperties."#"
ThirtyFiveMmFocalLength  = $ExtendedFileProperties."35mmFocalLength"
AccountName  = $ExtendedFileProperties.AccountName  
Album = $ExtendedFileProperties.Album  
AlbumArtist = $ExtendedFileProperties.AlbumArtist  
AlbumID = $ExtendedFileProperties.AlbumID  
Anniversary = $ExtendedFileProperties.Anniversary
BitDepth = $ExtendedFileProperties.BitDepth
BitRate = $ExtendedFileProperties.BitRate
Anniversary = $ExtendedFileProperties.Anniversary
Assistant'sName = $ExtendedFileProperties.Assistant'sName
Assistant'sPhone = $ExtendedFileProperties.Assistant'sPhone
Attachments = $ExtendedFileProperties.Attachments
Attributes = $ExtendedFileProperties.Attributes
Authors = $ExtendedFileProperties.Authors
Autosummary = $ExtendedFileProperties.Autosummary
Availability = $ExtendedFileProperties.Availability
Bcc = $ExtendedFileProperties.Bcc
BccAddresses = $ExtendedFileProperties.BccAddresses
Beats-per-minute = $ExtendedFileProperties.Beats-per-minute
BillingInformation = $ExtendedFileProperties.BillingInformation
Birthday = $ExtendedFileProperties.Birthday
BitDepth = $ExtendedFileProperties.BitDepth
BitRate = $ExtendedFileProperties.BitRate
BroadcastDate = $ExtendedFileProperties.BroadcastDate
BusinessAddress = $ExtendedFileProperties.BusinessAddress
BusinessCity = $ExtendedFileProperties.BusinessCity
BusinessCountry/Region = $ExtendedFileProperties.BusinessCountry/Region
BusinessCounty/Region = $ExtendedFileProperties.BusinessCounty/Region
BusinessFax = $ExtendedFileProperties.BusinessFax
BusinessHomepage = $ExtendedFileProperties.BusinessHomepage
BusinessP.O.Box = $ExtendedFileProperties.BusinessP.O.Box
BusinessPhone = $ExtendedFileProperties.BusinessPhone
BusinessPostcode = $ExtendedFileProperties.BusinessPostcode
BusinessStreet = $ExtendedFileProperties.BusinessStreet
ByLocation = $ExtendedFileProperties.ByLocation
Call-BackNumber = $ExtendedFileProperties.Call-BackNumber
CameraMaker = $ExtendedFileProperties.CameraMaker
CameraModel = $ExtendedFileProperties.CameraModel
CarPhone = $ExtendedFileProperties.CarPhone
Categories = $ExtendedFileProperties.Categories
Cc = $ExtendedFileProperties.Cc
CcAddresses = $ExtendedFileProperties.CcAddresses
ChannelNumber = $ExtendedFileProperties.ChannelNumber
Children = $ExtendedFileProperties.Children
City = $ExtendedFileProperties.City
Classification = $ExtendedFileProperties.Classification
ClientID = $ExtendedFileProperties.ClientID
ClosedCaptioning = $ExtendedFileProperties.ClosedCaptioning
Colour = $ExtendedFileProperties.Colour
Comments = $ExtendedFileProperties.Comments
Company = $ExtendedFileProperties.Company
CompanyMainphone = $ExtendedFileProperties.CompanyMainphone
Complete = $ExtendedFileProperties.Complete
Composers = $ExtendedFileProperties.Composers
Computer = $ExtendedFileProperties.Computer
Conductors = $ExtendedFileProperties.Conductors
Connected = $ExtendedFileProperties.Connected
ContactNames = $ExtendedFileProperties.ContactNames
ContentCreated = $ExtendedFileProperties.ContentCreated
ContentStatus = $ExtendedFileProperties.ContentStatus
ContentType = $ExtendedFileProperties.ContentType
ContributingArtists = $ExtendedFileProperties.ContributingArtists
Contributors = $ExtendedFileProperties.Contributors
ConversationID = $ExtendedFileProperties.ConversationID
Copyright = $ExtendedFileProperties.Copyright
Country/Region = $ExtendedFileProperties.Country/Region
County/Region = $ExtendedFileProperties.County/Region
Creators = $ExtendedFileProperties.Creators
DataRate = $ExtendedFileProperties.DataRate
Date = $ExtendedFileProperties.Date
DateAccessed = $ExtendedFileProperties.DateAccessed
DateAcquired = $ExtendedFileProperties.DateAcquired
DateArchived = $ExtendedFileProperties.DateArchived
DateCompleted = $ExtendedFileProperties.DateCompleted
DateCreated = $ExtendedFileProperties.DateCreated
DateLastSaved = $ExtendedFileProperties.DateLastSaved
DateModified = $ExtendedFileProperties.DateModified
DateReceived = $ExtendedFileProperties.DateReceived
DateReleased = $ExtendedFileProperties.DateReleased
DateSent = $ExtendedFileProperties.DateSent
DateTaken = $ExtendedFileProperties.DateTaken
DateVisited = $ExtendedFileProperties.DateVisited
Department = $ExtendedFileProperties.Department
Description = $ExtendedFileProperties.Description
Devicecategory = $ExtendedFileProperties.Devicecategory
Dimensions = $ExtendedFileProperties.Dimensions
Directors = $ExtendedFileProperties.Directors
DiscoveryMethod = $ExtendedFileProperties.DiscoveryMethod
Division = $ExtendedFileProperties.Division
DocumentID = $ExtendedFileProperties.DocumentID
DueDate = $ExtendedFileProperties.DueDate
Duration = $ExtendedFileProperties.Duration
Email2 = $ExtendedFileProperties.Email2
Email3 = $ExtendedFileProperties.Email3
EmailAddress = $ExtendedFileProperties.EmailAddress
EmailDisplayname = $ExtendedFileProperties.EmailDisplayname
EmailList = $ExtendedFileProperties.EmailList
EncodedBy = $ExtendedFileProperties.EncodedBy
EncryptedTo = $ExtendedFileProperties.EncryptedTo
EncryptionStatus = $ExtendedFileProperties.EncryptionStatus
EndDate = $ExtendedFileProperties.EndDate
EntryType = $ExtendedFileProperties.EntryType
EpisodeName = $ExtendedFileProperties.EpisodeName
EpisodeNumber = $ExtendedFileProperties.EpisodeNumber
Event = $ExtendedFileProperties.Event
ExifVersion = $ExtendedFileProperties.ExifVersion
ExposureBias = $ExtendedFileProperties.ExposureBias
ExposureProgram = $ExtendedFileProperties.ExposureProgram
ExposureTime = $ExtendedFileProperties.ExposureTime
F-Stop = $ExtendedFileProperties.F-Stop
FileAs = $ExtendedFileProperties.FileAs
FileCount = $ExtendedFileProperties.FileCount
FileDescription = $ExtendedFileProperties.FileDescription
FileExtension = $ExtendedFileProperties.FileExtension
Filename = $ExtendedFileProperties.Filename
FileVersion = $ExtendedFileProperties.FileVersion
FirstName = $ExtendedFileProperties.FirstName
FlagColour = $ExtendedFileProperties.FlagColour
FlagStatus = $ExtendedFileProperties.FlagStatus
FlashMode = $ExtendedFileProperties.FlashMode
FocalLength = $ExtendedFileProperties.FocalLength
Folder = $ExtendedFileProperties.Folder
FolderName = $ExtendedFileProperties.FolderName
FolderPath = $ExtendedFileProperties.FolderPath
FrameHeight = $ExtendedFileProperties.FrameHeight
FrameRate = $ExtendedFileProperties.FrameRate
FrameWidth = $ExtendedFileProperties.FrameWidth
Free/BusyStatus = $ExtendedFileProperties.Free/BusyStatus
FriendlyName = $ExtendedFileProperties.FriendlyName
From = $ExtendedFileProperties.From
FromAddresses = $ExtendedFileProperties.FromAddresses
FullName = $ExtendedFileProperties.FullName
FullStop = $ExtendedFileProperties.FullStop
Gender = $ExtendedFileProperties.Gender
Genre = $ExtendedFileProperties.Genre
GivenName = $ExtendedFileProperties.GivenName
Group = $ExtendedFileProperties.Group
HasAttachments = $ExtendedFileProperties.HasAttachments
HasFlag = $ExtendedFileProperties.HasFlag
Height = $ExtendedFileProperties.Height
Hobbies = $ExtendedFileProperties.Hobbies
HomeAddress = $ExtendedFileProperties.HomeAddress
HomeCity = $ExtendedFileProperties.HomeCity
HomeCountry/region = $ExtendedFileProperties.HomeCountry/region
HomeCounty/region = $ExtendedFileProperties.HomeCounty/region
HomeFax = $ExtendedFileProperties.HomeFax
HomeP.o.Box = $ExtendedFileProperties.HomeP.o.Box
HomePhone = $ExtendedFileProperties.HomePhone
HomePostcode = $ExtendedFileProperties.HomePostcode
HomeStreet = $ExtendedFileProperties.HomeStreet
HorizontalResolution = $ExtendedFileProperties.HorizontalResolution
ImAddresses = $ExtendedFileProperties.ImAddresses
Importance = $ExtendedFileProperties.Importance
Incomplete = $ExtendedFileProperties.Incomplete
InitialKey = $ExtendedFileProperties.InitialKey
Initials = $ExtendedFileProperties.Initials
IsAttachment = $ExtendedFileProperties.IsAttachment
IsCompleted = $ExtendedFileProperties.IsCompleted
IsDeleted = $ExtendedFileProperties.IsDeleted
IsOnline = $ExtendedFileProperties.IsOnline
IsoSpeed = $ExtendedFileProperties.IsoSpeed
IsRecurring = $ExtendedFileProperties.IsRecurring
ItemType = $ExtendedFileProperties.ItemType
JobTitle = $ExtendedFileProperties.JobTitle
Kind = $ExtendedFileProperties.Kind
Label = $ExtendedFileProperties.Label
Language = $ExtendedFileProperties.Language
LastPrinted = $ExtendedFileProperties.LastPrinted
LegalTrademarks = $ExtendedFileProperties.LegalTrademarks
Length = $ExtendedFileProperties.Length
LensMaker = $ExtendedFileProperties.LensMaker
LensModel = $ExtendedFileProperties.LensModel
LightSource = $ExtendedFileProperties.LightSource
LinkStatus = $ExtendedFileProperties.LinkStatus
LinkTarget = $ExtendedFileProperties.LinkTarget
LocalComputer = $ExtendedFileProperties.LocalComputer
Location = $ExtendedFileProperties.Location
Manufacturer = $ExtendedFileProperties.Manufacturer
MaxAperture = $ExtendedFileProperties.MaxAperture
MediaCreated = $ExtendedFileProperties.MediaCreated
MeetingStatus = $ExtendedFileProperties.MeetingStatus
MeteringMode = $ExtendedFileProperties.MeteringMode
MiddleName = $ExtendedFileProperties.MiddleName
Mileage = $ExtendedFileProperties.Mileage
MobilePhone = $ExtendedFileProperties.MobilePhone
Model = $ExtendedFileProperties.Model
Mood = $ExtendedFileProperties.Mood
Name = $ExtendedFileProperties.Name
Nickname = $ExtendedFileProperties.Nickname
OfficeLocation = $ExtendedFileProperties.OfficeLocation
OfflineStatus = $ExtendedFileProperties.OfflineStatus
OptionalAttendeeAddresses = $ExtendedFileProperties.OptionalAttendeeAddresses
OptionalAttendees = $ExtendedFileProperties.OptionalAttendees
OrganiserAddress = $ExtendedFileProperties.OrganiserAddress
OrganiserName = $ExtendedFileProperties.OrganiserName
Orientation = $ExtendedFileProperties.Orientation
OtherAddress = $ExtendedFileProperties.OtherAddress
OtherCity = $ExtendedFileProperties.OtherCity
OtherCountry/Region = $ExtendedFileProperties.OtherCountry/Region
OtherCounty/Region = $ExtendedFileProperties.OtherCounty/Region
OtherP.o.Box = $ExtendedFileProperties.OtherP.o.Box
OtherPostCode = $ExtendedFileProperties.OtherPostCode
OtherStreet = $ExtendedFileProperties.OtherStreet
Owner = $ExtendedFileProperties.Owner
P.O.box = $ExtendedFileProperties.P.O.box
Pager = $ExtendedFileProperties.Pager
Pages = $ExtendedFileProperties.Pages
Paired = $ExtendedFileProperties.Paired
ParentalRating = $ExtendedFileProperties.ParentalRating
ParentalRatingReason = $ExtendedFileProperties.ParentalRatingReason
Participants = $ExtendedFileProperties.Participants
PartOfACompilation = $ExtendedFileProperties.PartOfACompilation
PartOfSet = $ExtendedFileProperties.PartOfSet
Path = $ExtendedFileProperties.Path
People = $ExtendedFileProperties.People
PerceivedType = $ExtendedFileProperties.PerceivedType
PersonalTitle = $ExtendedFileProperties.PersonalTitle
PostalAddress = $ExtendedFileProperties.PostalAddress
Postcode = $ExtendedFileProperties.Postcode
PrimaryEmail = $ExtendedFileProperties.PrimaryEmail
PrimaryPhone = $ExtendedFileProperties.PrimaryPhone
Priority = $ExtendedFileProperties.Priority
Producers = $ExtendedFileProperties.Producers
ProductName = $ExtendedFileProperties.ProductName
ProductVersion = $ExtendedFileProperties.ProductVersion
Profession = $ExtendedFileProperties.Profession
ProgramDescription = $ExtendedFileProperties.ProgramDescription
ProgramMode = $ExtendedFileProperties.ProgramMode
ProgramName = $ExtendedFileProperties.ProgramName
Project = $ExtendedFileProperties.Project
Protected = $ExtendedFileProperties.Protected
Publisher = $ExtendedFileProperties.Publisher
Rating = $ExtendedFileProperties.Rating
ReadStatus = $ExtendedFileProperties.ReadStatus
RecordingTime = $ExtendedFileProperties.RecordingTime
ReminderTime = $ExtendedFileProperties.ReminderTime
RequiredAttendeeAddresses = $ExtendedFileProperties.RequiredAttendeeAddresses
RequiredAttendees = $ExtendedFileProperties.RequiredAttendees
Rerun = $ExtendedFileProperties.Rerun
Resources = $ExtendedFileProperties.Resources
SAP = $ExtendedFileProperties.SAP
Saturation = $ExtendedFileProperties.Saturation
SearchRanking = $ExtendedFileProperties.SearchRanking
SeasonNumber = $ExtendedFileProperties.SeasonNumber
SenderAddress = $ExtendedFileProperties.SenderAddress
SenderName = $ExtendedFileProperties.SenderName
Sensitivity = $ExtendedFileProperties.Sensitivity
Shared = $ExtendedFileProperties.Shared
SharedWith = $ExtendedFileProperties.SharedWith
Sharing = $ExtendedFileProperties.Sharing
SharingStatus = $ExtendedFileProperties.SharingStatus
SharingType = $ExtendedFileProperties.SharingType
Size = $ExtendedFileProperties.Size
Slides = $ExtendedFileProperties.Slides
Snippets = $ExtendedFileProperties.Snippets
SortAlbum = $ExtendedFileProperties.SortAlbum
SortAlbumArtist = $ExtendedFileProperties.SortAlbumArtist
SortComposer = $ExtendedFileProperties.SortComposer
SortContributingArtists = $ExtendedFileProperties.SortContributingArtists
SortTitle = $ExtendedFileProperties.SortTitle
Source = $ExtendedFileProperties.Source
SpaceFree = $ExtendedFileProperties.SpaceFree
SpaceUsed = $ExtendedFileProperties.SpaceUsed
Spouse/Partner = $ExtendedFileProperties.Spouse/Partner
StartDate = $ExtendedFileProperties.StartDate
StationCallSign = $ExtendedFileProperties.StationCallSign
StationName = $ExtendedFileProperties.StationName
Status = $ExtendedFileProperties.Status
Store = $ExtendedFileProperties.Store
Street = $ExtendedFileProperties.Street
Subject = $ExtendedFileProperties.Subject
SubjectDistance = $ExtendedFileProperties.SubjectDistance
Subtitle = $ExtendedFileProperties.Subtitle
Suffix = $ExtendedFileProperties.Suffix
Summary = $ExtendedFileProperties.Summary
SupportLink = $ExtendedFileProperties.SupportLink
Surname = $ExtendedFileProperties.Surname
Tags = $ExtendedFileProperties.Tags
TaskOwner = $ExtendedFileProperties.TaskOwner
TaskStatus = $ExtendedFileProperties.TaskStatus
Telex = $ExtendedFileProperties.Telex
Title = $ExtendedFileProperties.Title
To = $ExtendedFileProperties.To
ToAddresses = $ExtendedFileProperties.ToAddresses
TodoTitle = $ExtendedFileProperties.TodoTitle
TotalBitRate = $ExtendedFileProperties.TotalBitRate
TotalEditingTime = $ExtendedFileProperties.TotalEditingTime
TotalFileSize = $ExtendedFileProperties.TotalFileSize
TotalSize = $ExtendedFileProperties.TotalSize
TTY/TTDphone = $ExtendedFileProperties.TTY/TTDphone
Type = $ExtendedFileProperties.Type
URL = $ExtendedFileProperties.URL
UserWebURL = $ExtendedFileProperties.UserWebURL
VerticalResolution = $ExtendedFileProperties.VerticalResolution
Videocompression = $ExtendedFileProperties.Videocompression
VideoOrientation = $ExtendedFileProperties.VideoOrientation
WebPage = $ExtendedFileProperties.WebPage
WhiteBalance = $ExtendedFileProperties.WhiteBalance
Width = $ExtendedFileProperties.Width
WordCount = $ExtendedFileProperties.WordCount
Writers = $ExtendedFileProperties.Writers
Year = $ExtendedFileProperties.Year

    } #EndCustomObject
#>
$RawObject

<#

#>

      # $Mp3Object = New-Object -PSObject -Property $hash

      # return $Mp3Object
    } #EndForeach
  
  
  }
  End
  {
  }
}
 

# todo: function to just extract the mp3 stuff
#
 

 

# $X = Get-ExtendedFileProperties -folder "D:\music\Desm*" -verbose
# $X | select Size, Album
# vim: set softtabstop=2 shiftwidth=2 expandtab
