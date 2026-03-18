<?php
$imagesDir = '../images/';
$images = is_dir($imagesDir) ? array_diff(scandir($imagesDir), array('..', '.')) : [];

echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TomWizMaster Images HTML Gallery</title>
    <style>
        body { font-family: sans-serif; background-color: #121212; color: #f0f0f0; margin: 0; padding: 20px; }
        h1 { text-align: center; margin-bottom: 40px; font-weight: 300; }
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .card {
            background-color: #1e1e1e;
            border-radius: 8px;
            padding: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 6px rgba(0,0,0,0.5);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: scale(1.02);
        }
        img {
            max-width: 100%;
            height: auto;
            max-height: 200px;
            border-radius: 4px;
            object-fit: cover;
        }
        p {
            margin: 10px 0 0 0;
            font-size: 0.85em;
            color: #ccc;
            text-align: center;
            word-wrap: break-word;
            width: 100%;
        }
    </style>
</head>
<body>
    <h1>TomWizMaster Media Assets</h1>
    <div class="gallery">';

foreach ($images as $img) {
    if (is_file($imagesDir . $img)) {
        $imgPath = htmlspecialchars($imagesDir . $img);
        $imgName = htmlspecialchars($img);
        echo "<div class='card'>
                <img src=\"{$imgPath}\" alt=\"{$imgName}\" loading=\"lazy\">
                <p>{$imgName}</p>
              </div>";
    }
}

echo '    </div>
</body>
</html>';
?>
