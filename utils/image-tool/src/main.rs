use clap::Parser;
use image::ImageReader;
use std::path::Path;

fn blur_image(input_path: &str, output_path: &str, sigma: f32) -> Result<(), image::ImageError> {
    let img = ImageReader::open(input_path)?.with_guessed_format()?;
    let format = img.format();
    let img = img.decode()?;

    let blurred_img = img.blur(sigma);

    match format {
        Some(format) => blurred_img.save_with_format(&Path::new(output_path), format)?,
        _ => blurred_img.save(&Path::new(output_path))?,
    }

    Ok(())
}

#[derive(clap::Subcommand)]
enum Commands {
    /// Blur image
    Blur {
        sigma: f32,
        input: String,
        output: String,
    },
}

#[derive(clap::Parser)]
#[command(version, about)]
struct Cli {
    /// Commands
    #[command(subcommand)]
    command: Commands,
}

fn main() {
    let cli = Cli::parse();
    let _ = match cli.command {
        Commands::Blur {
            sigma,
            input,
            output,
        } => blur_image(&input, &output, sigma),
    }
    .inspect_err(|err| println!("Failed: {err}"))
    .unwrap();
}
