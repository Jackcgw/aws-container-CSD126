Storage Reflection
3.1. How does your app allow users to upload and view photos if S3 objects are private?

Even though S3 objects are private by default, the app uses pre-signed URLs to give temporary access. The Flask backend generates these URLs using AWS credentials and sends them to the client.

For uploads, the app creates a pre-signed URL that lets the browser send the file directly to S3. For viewing photos, it creates a URL that allows a temporary download of the image.

This works without changing bucket permissions because the URLs are signed, time-limited, and only allow access to specific objects. So the bucket stays private, but users can still upload and view their photos securely.

3.2. Why are the two GSIs useful and why were those key choices correct?

The GSIs are useful because they let the app query the data in ways the main table can’t.

One GSI uses the user ID as the hash key, which makes it easy to get all photos for a specific user. The timestamp as the range key lets the app sort those photos by time.

The other GSI groups photos in a way that supports a feed or shared view, again using a timestamp so results can be ordered.

These choices make sense because the app mostly needs to get photos by user or show them in time order, and GSIs make those queries efficient without scanning the whole table.