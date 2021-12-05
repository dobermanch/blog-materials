namespace DictionaryBinder.Controllers;

public class UploadRequest
{
    public IFormFile File { get; set; }

    public IDictionary<string, string> Metadata { get; set; }
}
